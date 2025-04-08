import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/handingdatacontroller.dart';
import 'package:credit_app/data/datasource/remote/auth/verifycodesignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/routes.dart';

abstract class VerifycodeSignupController extends GetxController {
  CheckCode();
  goToLogin(String verifycodesignup);
}

class VerifycodeSignupControllerImp extends VerifycodeSignupController {
  VerifycodeSignupData verifycodeSignupData = VerifycodeSignupData(Get.find());
  String? email;
  StatusRequest? statusRequest;

  @override
  void onInit() {
    email = Get.arguments?['email']?.toString();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  CheckCode() {
    // Implémentation existante
  }

  @override
  goToLogin(verifycodesignup) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await verifycodeSignupData.postData(email!, verifycodesignup);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoute.successPage);
        } else {
          Get.defaultDialog(
            title: "62".tr,
            middleText: response['message'] ?? "65".tr,
          );
          statusRequest = StatusRequest.fail;
        }
      } else {
        if (statusRequest == StatusRequest.offlinefailure) {
          Get.defaultDialog(
            title: "62".tr,
            middleText: "63".tr,
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black),
            middleTextStyle: TextStyle(color: Colors.black),
            radius: 12,
            barrierDismissible: false,
          );
        } else {
          Get.defaultDialog(
            title: "60".tr,
            middleText: _getErrorMessage(statusRequest),
          );
        }
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Erreur".tr,
        middleText: "Problème de connexion au serveur: ${e.toString()}".tr,
      );
      statusRequest = StatusRequest.serverexception;
    } finally {
      update();
    }
  }

  String _getErrorMessage(StatusRequest? status) {
    switch (status) {
      case StatusRequest.serverfailure:
        return "error server".tr;
      case StatusRequest.serverexception:
        return "65".tr;
      case StatusRequest.fail:
        return "Échec de l'opération".tr;
      default:
        return "Une erreur inconnue est survenue".tr;
    }
  }
}