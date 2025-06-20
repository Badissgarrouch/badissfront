import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/handingdatacontroller.dart';
import 'package:credit_app/data/datasource/remote/auth/verifycodeotpereset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';

abstract class VerifycodeController extends GetxController {
  checkCode();
  goToResetPassword(String verifyPasswordResetOtp);
}

class VerifycodeControllerImp extends VerifycodeController {
  late String verifycode;
  String? email;
  String? resetToken;
  final VerifycodeotperesetData verifycodeotperesetData = VerifycodeotperesetData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    email = Get.arguments?['email'];
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  checkCode() {
  }

  @override
  Future<void> goToResetPassword(String verifyPasswordResetOtp) async {


    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await verifycodeotperesetData.postData(email!, verifyPasswordResetOtp);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          Get.toNamed(AppRoute.resetPassword, arguments: {'email':email,'resetToken': response['resetToken']});
        } else {
          _handleVerificationError(response);
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

  void _handleVerificationError(Map response) {
    final errorMessage = response['message']?.toString().toLowerCase() ?? '';

    if (errorMessage.contains('incorrect') || errorMessage.contains('invalid')) {
      _showErrorDialog(
        title: "Code incorrect".tr,
        message: "Le code de vérification est incorrect".tr,
      );
    } else if (errorMessage.contains('expired')) {
      _showErrorDialog(
        title: "Code expiré".tr,
        message: "Le code de vérification a expiré".tr,
      );
    } else {
      _showErrorDialog(
        title: "Erreur".tr,
        message: response['message'] ?? "Échec de la vérification".tr,
      );
    }

    statusRequest = StatusRequest.fail;
  }

  void _handleStatusRequestError() {

    String title = "⚠ Attention".tr;
    String message;

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
        message = "Verify code not correct".tr;
        break;
      default:
        message = "Erreur inconnue".tr;
    }

    _showErrorDialog(
      title: title,
      message: message,
    );
  }

  void _handleServerError(dynamic e) {
    statusRequest = StatusRequest.serverexception;
    _showErrorDialog(
      title: "Erreur serveur".tr,
      message: "Problème de connexion au serveur: ${e.toString()}".tr,
    );
  }

  void _showErrorDialog({required String title, required String message}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
    );
  }
}