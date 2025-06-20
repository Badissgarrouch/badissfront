import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../conroller/home/profile_controller.dart';


class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => ListTile(
      leading: Icon(
        controller.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
        color: Colors.yellow,
      ),
      title: Text(
        "Dark mode".tr,
        style: TextStyle(
          fontSize: 16.0,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.8,
        child: Switch(
          value: controller.isDarkMode.value,
          onChanged: controller.toggleDarkMode,
          activeColor: Colors.yellow,
          inactiveTrackColor: Colors.grey[400],
        ),
      ),
    ));
  }
}