import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../conroller/home/profile_controller.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => ListTile(
      leading: Icon(Icons.notifications, color: Colors.purple),
      title: Text(
        "Notifications".tr,
        style: TextStyle(
          fontSize: 16.0,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.8,
        child: Switch(
          value: controller.isNotificationEnabled.value,
          onChanged: controller.toggleNotifications,
          activeColor: Colors.purple,
          inactiveTrackColor: Colors.grey[400],
        ),
      ),
    ));
  }
}