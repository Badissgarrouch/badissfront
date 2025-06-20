import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../conroller/home/profile_controller.dart';
import 'package:credit_app/core/localization/changedlocal.dart'; // Import your LocaleController

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  String _getCurrentLanguageName(String langCode) {
    switch (langCode) {
      case "fr":
        return "Français";
      case "en":
        return "Anglais";
      case "ar":
        return "Arabe";
      default:
        return "Français";
    }
  }

  Widget _buildLanguageOption(BuildContext context, String label, String flag) {
    final ProfileController controller = Get.find<ProfileController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => RadioListTile<String>(
      title: Text(
        "$flag  $label",
        style: TextStyle(
          fontSize: 16.0,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      value: label,
      groupValue: controller.selectedLanguage.value,
      onChanged: (String? value) {
        if (value != null) controller.updateLanguage(value);
      },
      activeColor: Colors.orange,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localeController = Get.find<LocaleController>();
    final profileController = Get.find<ProfileController>();

    // Initialize the selected language based on current locale
    if (profileController.selectedLanguage.value.isEmpty) {
      profileController.selectedLanguage.value =
          _getCurrentLanguageName(localeController.language?.languageCode ?? 'fr');
    }

    return ExpansionTile(
      leading: Icon(Icons.language, color: Colors.orange),
      title: Text(
        "Languages".tr, // Make sure this is in your translation files
        style: TextStyle(
          fontSize: 16.0,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      children: [
        _buildLanguageOption(context, "French".tr, "🇫🇷"),
        _buildLanguageOption(context, "English".tr, "🇬🇧"),
        _buildLanguageOption(context, "Arabic".tr, "🇸🇦"),
      ],
    );
  }
}