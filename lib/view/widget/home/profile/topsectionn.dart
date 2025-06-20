import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/conroller/home/profile_controller.dart';
import 'contactus/contact.dart';
import 'featuree.dart';
import 'langue/languetile.dart';
import 'listtile.dart';
import 'notifi/notificationtile.dart';
import 'mode/darkmode.dart';


Widget buildTopSection(BuildContext context) {
  final controller = Get.find<ProfileController>();
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: controller.isDarkMode.value ? Colors.grey[850] : Colors.white,
      child: Column(
        children: [
          buildListTileWithAction(
            context: context,
            icon: Icons.help,
            color: Colors.blue,
            title: "Contact us".tr,
            action: () => showContactDialog(context),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ExpansionTile(
            leading: Icon(Icons.info_outline, color: Colors.green),
            title: Text(
              "About Us".tr,
              style: TextStyle(
                fontSize: 16.0,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildFeatureItem(context, "Application Name".tr, "Credit App"),
                    buildFeatureItem(context, "Version".tr, "0.0.1"),
                    buildFeatureItem(context, "Created on".tr, "05/09/2025"),
                    buildFeatureItem(context, "Developed by".tr, "Badiss Garrouch"),
                    const SizedBox(height: 10),
                    Text(
                      "This application was designed to facilitate credit management between merchants and their customers.".tr+
                      "It enables intelligent, secure, and rapid tracking of all transactions.".tr,
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          const LanguageTile(),
          const Divider(height: 1, indent: 16, endIndent: 16),
          const NotificationTile(),
          const Divider(height: 1, indent: 16, endIndent: 16),
          const DarkModeTile(),
        ],
      ),
    ),
  );
}