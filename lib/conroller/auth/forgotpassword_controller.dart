import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/handingdatacontroller.dart';
import 'package:credit_app/data/datasource/remote/auth/forgotpassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';

abstract class ForgotpasswordController extends GetxController {
  checkEmail();
  goToVerifyCode();
}

class ForgotPasswordControllerImp extends ForgotpasswordController {
  final ForgotpasswordData forgotpasswordData = ForgotpasswordData(Get.find());
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  StatusRequest? statusRequest;

  @override
  Future<void> checkEmail() async {
    if (!formstate.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    try {
      final response = await forgotpasswordData.postData(email.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          Get.offNamed(
            AppRoute.verifyCode,
            arguments: {"email": email.text},
          );
        } else {
          _handleEmailNotFound(response);
        }
      } else {
        _handleStatusRequestError();
      }
    } catch (e) {
      _handleServerError(e);
    } finally {
      update();
    }
  }

  void _handleEmailNotFound(Map response) {
    final message = response['message']?.toString().toLowerCase() ?? '';

    if (message.contains('not found') || message.contains('introuvable')) {
      Get.defaultDialog(
        title: "Email introuvable".tr,
        middleText: "No account is associated with this email".tr,
      );
    } else {
      Get.defaultDialog(
        title: "Erreur".tr,
        middleText: response['message'] ?? "Email non valide".tr,
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
        message = "No account is associated with this email".tr;
        break;
      default:
        message = "Erreur inconnue".tr;
    }

    Get.defaultDialog(
      title: title,
      middleText: message,
    );
  }

  void _handleServerError(dynamic e) {
    statusRequest = StatusRequest.serverexception;
    Get.defaultDialog(
      title: "Erreur serveur".tr,
      middleText: "Une erreur est survenue: ${e.toString()}".tr,
    );
    print('Forgot password error: $e');
  }

  @override
  void goToVerifyCode() {
    Get.toNamed(AppRoute.verifyCode);
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}