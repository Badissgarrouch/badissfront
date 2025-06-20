import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/conroller/home/profile_controller.dart';
import 'eldailog.dart';

import '../listtile.dart';
import '../parametre/parametretile.dart';

Widget buildBottomSection(BuildContext context) {
  final controller = Get.find<ProfileController>();
  Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: controller.isDarkMode.value ? Colors.grey[850] : Colors.white,
      child: Column(
        children: [
          const AdvancedSettingsTile(),
          const Divider(height: 1, indent: 16, endIndent: 16),
          buildListTileWithAction(
            context: context,
            icon: Icons.logout,
            color: Colors.red,
            title: "Disconnect".tr,
            action: () => showLogoutDialog(context),
          ),
        ],
      ),
    ),
  );
}