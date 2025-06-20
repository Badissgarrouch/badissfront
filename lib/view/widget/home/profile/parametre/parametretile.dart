import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'advancedparametredialog.dart';

class AdvancedSettingsTile extends StatelessWidget {
  const AdvancedSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(Icons.settings, color: Colors.grey),
      title: Text(
        "Advanced settings".tr,
        style: TextStyle(
          fontSize: 16.0,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () => showAdvancedSettingsDialog(context),
    );
  }
}