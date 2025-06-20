import 'package:get/get.dart';
import 'package:credit_app/core/function/datesort.dart';
import 'package:credit_app/core/services/filter.dart';
import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:credit_app/view/widget/notification/noti_type.dart';
import '../../data/datasource/remote/notification/donnee.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationItem>[].obs;
  final filterStates = <NotificationType, bool>{}.obs;
  final selectAllFilters = true.obs;
  final isLoading = false.obs;
  final isConnected = false.obs;
  final notificationCount = 0.obs;
  String? userToken;

  final NotificationDataService dataService = NotificationDataService();
  final FilterService filterService = FilterService();
  final NotificationSortingUtils sortingUtils = NotificationSortingUtils();
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    userToken = box.read('token');
    if (userToken == null || userToken!.isEmpty) {
      print('Erreur: Aucun token utilisateur disponible');
    }
    initialize();
  }

  @override
  void onClose() {
    dataService.disconnectWebSocket();
    super.onClose();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    await loadNotifications();
    await loadFilters();
    updateNotificationCount();
    isLoading.value = false;

    if (userToken != null && userToken!.isNotEmpty) {
      dataService.connectWebSocket(
            (notification) {
          addNotification(notification);
        },
        onConnectionStatus: (connected) {
          isConnected.value = connected;
        },
        userToken: userToken!,
      );
    }
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;
      final dynamicNotifications = userToken != null && userToken!.isNotEmpty
          ? await _fetchNotificationsWithRetry()
          : <NotificationItem>[];

      final storedNotifications = userToken != null && userToken!.isNotEmpty
          ? await dataService.loadDynamicNotifications(userToken!)
          : <NotificationItem>[];

      final allNotifications = [...dynamicNotifications, ...storedNotifications];
      final seenIds = <String>{};
      notifications.value = allNotifications.where((n) {
        if (n.id == null) return false;
        if (seenIds.contains(n.id)) return false;
        seenIds.add(n.id!);
        return true;
      }).toList();

      if (userToken != null && userToken!.isNotEmpty && notifications.isNotEmpty) {
        await dataService.storageService.saveDynamicNotifications(notifications, userToken!);
      }
      updateNotificationCount();
    } catch (e) {
      print('Erreur lors du chargement des notifications: $e');
      if (userToken != null && userToken!.isNotEmpty) {
        notifications.value = await dataService.loadDynamicNotifications(userToken!);
        updateNotificationCount();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<NotificationItem>> _fetchNotificationsWithRetry({int retries = 3, int delayMs = 1000}) async {
    for (int attempt = 1; attempt <= retries; attempt++) {
      try {
        return await dataService.fetchDynamicNotifications(userToken!);
      } catch (e) {
        if (attempt < retries) {
          await Future.delayed(Duration(milliseconds: delayMs));
        } else {
          throw Exception('Échec de récupération des notifications après $retries tentatives');
        }
      }
    }
    return [];
  }

  Future<void> loadFilters() async {
    try {
      final filters = await filterService.loadFilterPreferences();
      filterStates.value = filters;
      selectAllFilters.value = filters.values.every((v) => v);
      updateNotificationCount();
    } catch (e) {
      print('Erreur lors du chargement des filtres: $e');
    }
  }

  void updateNotificationCount() {
    final groupedNotifications = filterAndGroupNotifications();
    notificationCount.value = groupedNotifications.fold<int>(
      0,
          (sum, group) => sum + (group['notifications'] as List).length,
    );
  }

  void updateFilterStates(Map<NotificationType, bool> newFilters, bool newSelectAll) {
    filterStates.assignAll(newFilters);
    selectAllFilters.value = newSelectAll;
    filterService.saveFilterPreferences(newFilters);
    updateNotificationCount();
    notifications.refresh();
  }

  void resetFilters() {
    filterStates.updateAll((key, value) => true);
    selectAllFilters.value = true;
    filterService.saveFilterPreferences(filterStates);
    updateNotificationCount();
  }

  void clearNotifications() async {
    isLoading.value = true;
    notifications.clear();
    if (userToken != null && userToken!.isNotEmpty) {
      await dataService.storageService.saveDynamicNotifications([], userToken!);
    }
    updateNotificationCount();
    isLoading.value = false;
  }

  void handleNotificationAction(String action, NotificationItem notification) {
    if (userToken != null && userToken!.isNotEmpty) {
      dataService.handleNotificationAction(action, notification, userToken!);
      notifications.refresh();
      updateNotificationCount();
    }
  }

  List<Map<String, dynamic>> filterAndGroupNotifications() {
    return sortingUtils.filterAndGroupNotifications(
      notifications: notifications,
      filterStates: filterStates,
    );
  }

  void logout() {
    dataService.logout(userToken);
    box.remove('token');
    userToken = null;
  }

  void addNotification(NotificationItem notification) {
    if (notification.id != null && !notifications.any((n) => n.id == notification.id)) {
      notifications.add(notification);
      updateNotificationCount();
      notifications.refresh();
      if (userToken != null && userToken!.isNotEmpty) {
        dataService.storageService.saveDynamicNotifications([notification], userToken!);
      }
    }
  }
}