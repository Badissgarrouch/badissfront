import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/data/datasource/remote/home/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:credit_app/core/localization/changedlocal.dart';

import '../../data/datasource/remote/auth/updatename.dart';

class ProfileController extends GetxController {
  final RxString selectedLanguage = 'Français'.obs;
  final RxBool isDarkMode = false.obs;
  final RxBool isNotificationEnabled = true.obs;
  final UserDataSource userDataSource = UserDataSource(crud: Crud());
  final box = GetStorage();
  final Rx<SearchModel?> user = Rx<SearchModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final email = box.read('current_user');
    if (email != null) {
      user.value = SearchModel(
        id: box.read('userId')?.toString() ?? '',
        firstName: box.read('${email}_firstName') ?? '',
        lastName: box.read('${email}_lastName') ?? '',
        email: email,
        userType: '',
      );
    }
  }

  Future<void> updateUserInfo(String firstName, String lastName) async {
    final String? token = box.read('token');
    final String? email = box.read('current_user');

    if (token == null || email == null) {
      Get.snackbar("Erreur".tr, "Vous devez être connecté pour effectuer cette action".tr,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final response = await userDataSource.updateUserInfo(
      token: token,
      firstName: firstName.isNotEmpty ? firstName : null,
      lastName: lastName.isNotEmpty ? lastName : null,
    );

    response.fold(
          (status) {
        Get.snackbar("Erreur".tr, _getErrorMessage(status), backgroundColor: Colors.red, colorText: Colors.white);
      },
          (searchModel) async {
        await box.write('${email}_firstName', searchModel.firstName);
        await box.write('${email}_lastName', searchModel.lastName);
        await box.write('userId', searchModel.id);
        user.value = searchModel;
        Get.snackbar("Succès".tr, "mis à jour fait avec succès".tr, backgroundColor: Colors.green, colorText: Colors.white);
      },
    );
  }

  String _getErrorMessage(StatusRequest status) {
    switch (status) {
      case StatusRequest.authfailure:
        return "Token invalide ou expiré".tr;
      case StatusRequest.serverfailure:
        return "Erreur du serveur, veuillez réessayer".tr;
      case StatusRequest.offlinefailure:
        return "Pas de connexion Internet".tr;
      default:
        return "Erreur inconnue".tr;
    }
  }

  void updateLanguage(String language) {
    selectedLanguage.value = language;
    final langCode = {"Français": "fr", "Anglais": "en", "Arabe": "ar"}[language] ?? "fr";
    Get.find<LocaleController>().changeLang(langCode);
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
  }

  void toggleNotifications(bool value) {
    isNotificationEnabled.value = value;
  }
}