import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/handingdatacontroller.dart';
import 'package:credit_app/data/datasource/remote/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart' ;

import '../../core/constant/routes.dart';
import '../notification/appController.dart';

abstract class LoginController extends GetxController {
  login();
  goTosignup();
  showPassword();
}

class LoginControllerImp extends LoginController {
  final LoginData loginData = LoginData(Get.find());
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  bool isshowpassword = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final box = GetStorage();
  final AppController appController = Get.find<AppController>();

  @override
  void showPassword() {
    isshowpassword = !isshowpassword;
    update();
  }

  @override
  Future<void> login() async {
    if (!formstate.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await loginData.postData(email.text, password.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          final token = response['token'];
          final userData = response['data']['user'];

          await box.write('current_user', email.text);
          await box.write('token', token);
          await box.write('${email.text}_firstName', userData['firstName']);
          await box.write('${email.text}_lastName', userData['lastName']);
          await box.write('userId', userData['id']);

          // Mettre à jour le token dans AppController
          appController.setUserToken(token);

          final userType = int.tryParse(response['data']['user']['userType']?.toString() ?? '') ?? -1;
          Get.offNamed(userType == 1 ? AppRoute.homeScreen : AppRoute.homeScreenCommercant);
        } else {
          _handleLoginError(response);
        }
      } else {
        _handleStatusRequestError();
      }
    } catch (e) {
      _handleException(e);
    } finally {
      update();
    }
  }


  void _handleLoginError(Map response) {
    final errorMessage = response['message']?.toString().toLowerCase() ?? '';

    if (errorMessage.contains('email') || errorMessage.contains('password')) {
      Get.defaultDialog(
        title: "Erreur de connexion".tr,
        middleText: "Email or Password not correct".tr,
      );
    } else if (errorMessage.contains('exists')) {
      Get.defaultDialog(
        title: "Compte existant".tr,
        middleText: "Un compte avec ces identifiants existe déjà".tr,
      );
    } else {
      Get.defaultDialog(
        title: "Warning".tr,
        middleText: "Échec de la connexion: ${response['message'] ?? 'Raison inconnue'}".tr,
      );
    }

    statusRequest = StatusRequest.fail;
  }

  void _handleStatusRequestError() {
    String message;
    String title = "⚠ Attention".tr;

    if (statusRequest == StatusRequest.offlinefailure) {
      Get.defaultDialog(
        title: "❌network error🌐".tr,
        middleText: "Please check your internet connection".tr,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.black),
        middleTextStyle: TextStyle(color: Colors.black),
        radius: 12,
        barrierDismissible: false,
      );
      return;
    }

    switch (statusRequest) {
      case StatusRequest.serverfailure:
        message = "Erreur du serveur".tr;
        break;
      case StatusRequest.serverexception:
        message = "Email or Password not correct".tr;
        break;
      default:
        message = "Email or Password not correct".tr;
    }

    Get.defaultDialog(
      title: title,
      middleText: message,
    );
  }

  void _handleException(dynamic e) {
    statusRequest = StatusRequest.serverexception;
    Get.defaultDialog(
      title: "Erreur serveur".tr,
      middleText: "Une erreur est survenue: ${e.toString()}".tr,
    );
    print('Login error: $e');
  }

  @override
  void goTosignup() {
    Get.toNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}