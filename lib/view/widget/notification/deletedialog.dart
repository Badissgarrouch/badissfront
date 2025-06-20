import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../conroller/notification/notification_controller.dart';

class ClearNotificationsDialog extends StatelessWidget {
  const ClearNotificationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('Confirmation'.tr, style: TextStyle(color: Colors.blue[800])),
      content: Text('Are you sure you want to delete all notifications?'.tr),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'.tr, style: TextStyle(color: Colors.blue[600])),
        ),
        TextButton(
          onPressed: () {
            controller.clearNotifications();
            Get.back();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red[600]!, Colors.red[800]!]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Delete'.tr, style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}