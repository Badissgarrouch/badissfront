import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/data/datasource/remote/auth/resetpassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/routes.dart';

abstract class ResetPasswordController extends GetxController {
  void goToSuccessSignUp();
  void resetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  final ResetpasswordData resetPasswordData = ResetpasswordData(Get.find());

  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  late String resetToken; // Doit venir de verifyPasswordResetOtp
  bool isShowPassword = true;
  StatusRequest? statusRequest;

  showPassword(){
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  void onInit() {
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    resetToken = Get.arguments?['resetToken'] ??''; // Récupère le token depuis la navigation
    super.onInit();
  }


  @override
  void resetPassword() async {
    try {
      // Validation côté frontend
      if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
        Get.snackbar(
          "68".tr,
          "69".tr,
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 3),
        );
        return;
      }

      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar(
          "68".tr,
          "64".tr,
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 3),
        );
        return;
      }

      if (newPasswordController.text.length < 8) {
        Get.snackbar(
          "68".tr,
          "70".tr,
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 3),
        );
        return;
      }

      statusRequest = StatusRequest.loading;
      update();

      // Appel API avec le token récupéré dans onInit()
      final response = await resetPasswordData.postData(
        resetToken, // JWT token déjà récupéré
        newPasswordController.text,
        confirmPasswordController.text,
      );

      if (response is Map<String, dynamic>) {
        if (response['status'] == "success") {
          Get.offAllNamed(AppRoute.successPageReset);
        } else {
          Get.snackbar("Erreur".tr, response['message'] ?? "Échec de la réinitialisation".tr);
        }
      } else {
        Get.snackbar("Erreur".tr, "Réponse inattendue du serveur".tr);
      }
    } catch (e) {
      Get.snackbar("Erreur critique".tr, "Impossible de se connecter au serveur".tr);
    } finally {
      statusRequest = StatusRequest.success;
      update();
    }
  }

  @override
  void goToSuccessSignUp() {
    Get.offAllNamed(AppRoute.successPage);
  }
}
