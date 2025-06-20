import 'package:credit_app/core/services/dynamicnoti1.dart';
import 'package:credit_app/core/services/parser1.dart';
import 'package:credit_app/core/services/storagenoti.dart';
import 'package:credit_app/core/services/socket.dart';
import 'package:credit_app/core/services/actions.dart';
import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

class NotificationDataService {
  final DynamicNotificationService dynamicService;
  final StorageService storageService;
  final WebSocketService webSocketService;
  final ActionService actionService;
  final NotificationParserService parserService;

  NotificationDataService()
      : dynamicService = DynamicNotificationService(
      parserService: NotificationParserService()),
        parserService = NotificationParserService(),
        storageService = StorageService(
            box: GetStorage(), parserService: NotificationParserService()),
        webSocketService = WebSocketService(
            parserService: NotificationParserService()),
        actionService = ActionService(
            storageService: StorageService(
                box: GetStorage(), parserService: NotificationParserService()));

  Future<List<NotificationItem>> fetchDynamicNotifications(
      String userToken) async {
    if (userToken.isEmpty) {
      print('Erreur: Token utilisateur vide');
      return [];
    }

    print('Récupération des notifications dynamiques pour token: $userToken');
    final notifications1 = await dynamicService.fetchDynamicNotifications(userToken);
    final notifications2 = await dynamicService.fetchDynamicNotifications2(userToken);
    print('Notifications backend 1: ${notifications1.length}, backend 2: ${notifications2.length}');

    final allNotifications = [...notifications1, ...notifications2];
    final seenIds = <String>{};
    final uniqueNotifications = allNotifications.where((n) {
      if (n.id == null) {
        print('Notification sans ID exclue: ${n.title}');
        return false;
      }
      if (seenIds.contains(n.id)) {
        print('Doublon détecté, ID: ${n.id}');
        return false;
      }
      seenIds.add(n.id!);
      return true;
    }).toList();
    print('Notifications uniques après fusion: ${uniqueNotifications.length}');

    if (uniqueNotifications.isNotEmpty) {
      print('Enregistrement des notifications dans GetStorage');
      await storageService.saveDynamicNotifications(uniqueNotifications, userToken);
    }
    return uniqueNotifications;
  }

  Future<List<NotificationItem>> loadDynamicNotifications(
      String? userToken) async {
    if (userToken == null || userToken.isEmpty) {
      print('Erreur: Token utilisateur null ou vide');
      return [];
    }
    print('Chargement des notifications locales pour token: $userToken');
    final notifications = await storageService.loadDynamicNotifications(userToken);
    print('Notifications locales chargées: ${notifications.length}');
    return notifications;
  }

  void handleNotificationAction(String action, NotificationItem notification,
      String userToken) {
    print('Traitement de l’action: $action pour notification ${notification.id}');
    actionService.handleNotificationAction(action, notification, userToken);
  }

  void connectWebSocket(void Function(NotificationItem) onNewNotification, {
    void Function(bool)? onConnectionStatus,
    required String userToken,
  }) {
    print('Connexion aux WebSockets pour token: $userToken');
    webSocketService.connectWebSocket(
          (notification) {
        print('Notification WebSocket reçue (backend 1): ${notification.id}');
        onNewNotification(notification);
        storageService.saveDynamicNotifications([notification], userToken);
      },
      onConnectionStatus: onConnectionStatus,
      userToken: userToken,
      server: 'first',
    );
    webSocketService.connectWebSocket(
          (notification) {
        print('Notification WebSocket reçue (backend 2): ${notification.id}');
        onNewNotification(notification);
        storageService.saveDynamicNotifications([notification], userToken);
      },
      onConnectionStatus: onConnectionStatus,
      userToken: userToken,
      server: 'second',
    );
  }

  void disconnectWebSocket() {
    print('Déconnexion des WebSockets');
    webSocketService.disconnectWebSocket();
  }

  void logout(String? userToken) {
    print('Déconnexion de l’utilisateur, token: $userToken');
    disconnectWebSocket();
    print('Déconnexion terminée, notifications préservées');
  }
}