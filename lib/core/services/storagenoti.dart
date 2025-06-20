import 'package:credit_app/core/services/parser1.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../view/widget/notification/noti_items.dart';

class StorageService {
  final GetStorage box;
  final NotificationParserService parserService;

  StorageService({required this.box, required this.parserService});

  Future<void> saveDynamicNotifications(List<NotificationItem> notifications, String userToken) async {
    try {
      final notificationsJson = notifications.map((n) => parserService.notificationToJson(n)).toList();
      await box.write('dynamic_notifications_$userToken', notificationsJson);
      print('Saved ${notifications.length} notifications for user $userToken');
    } catch (e) {
      print('Error saving dynamic notifications for user $userToken: $e');
    }
  }

  Future<List<NotificationItem>> loadDynamicNotifications(String userToken) async {
    try {
      final notificationsJson = box.read<List<dynamic>>('dynamic_notifications_$userToken') ?? [];
      return notificationsJson
          .map((json) => parserService.parseNotificationFromJson(Map<String, dynamic>.from(json)))
          .toList(growable: false);
    } catch (e) {
      print('Error loading dynamic notifications for user $userToken: $e');
      return [];
    }
  }
}