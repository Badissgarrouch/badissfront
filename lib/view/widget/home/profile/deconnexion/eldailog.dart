import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/core/constant/routes.dart';
import 'package:credit_app/conroller/notification/appController.dart';
import 'package:credit_app/conroller/notification/notification_controller.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../../../../core/component/logout.dart';


void showLogoutDialog(BuildContext context) {
  Get.dialog(
    LogoutDialog(
      onLogout: () {
        final appController = Get.find<AppController>();
        final notificationController = Get.find<NotificationController>();
        final box = GetStorage();
        appController.logout();
        notificationController.logout();
        box.remove('token');
        box.remove('current_user');
        Get.offAllNamed(AppRoute.login);
      },
    ),
    barrierDismissible: false,
  );
}