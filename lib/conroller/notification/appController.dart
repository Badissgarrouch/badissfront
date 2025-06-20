import 'package:get/get.dart';

import '../../data/datasource/remote/notification/donnee.dart';
import 'notification_controller.dart';

class AppController extends GetxController {
  final NotificationDataService dataService = NotificationDataService();
  String? userToken;

  @override
  void onInit() {
    super.onInit();
    initializeWebSocket();
  }

  void setUserToken(String? token) {
    userToken = token;
    if (userToken != null) {
      initializeWebSocket();
    } else {
      dataService.disconnectWebSocket();
    }
  }

  void initializeWebSocket() {
    if (userToken != null) {
      dataService.connectWebSocket(
            (notification) {
          final notificationController = Get.find<NotificationController>();
          notificationController.addNotification(notification);
        },
        onConnectionStatus: (connected) {
          print('AppController WebSocket status: $connected');
        },
        userToken: userToken!,
      );
    }
  }

  void logout() {
    dataService.logout(userToken);
    userToken = null;
  }
}