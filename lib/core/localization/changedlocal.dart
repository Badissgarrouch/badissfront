import 'dart:ui';

import 'package:credit_app/core/services/services.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPreflang = myServices.sharedPreferences.getString("lang");
    if (sharedPreflang == "en") {
      language = const Locale("en");
    }
    else if (sharedPreflang == "fr") {
      language = const Locale("fr");
    }
    else if (sharedPreflang == "ar") {
      language = const Locale("ar");
    }
    else {
      language = Locale(Get.deviceLocale!.languageCode);
      super.onInit();
    }
  }
}