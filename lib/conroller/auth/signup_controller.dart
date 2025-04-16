import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/handingdatacontroller.dart';
import 'package:credit_app/data/datasource/remote/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../core/constant/routes.dart';

abstract class SignUpController extends GetxController {
  void signUp();
  void goToSignIn();
  void goToSc();
}

class SignUpControllerImp extends SignUpController {
  String userType = '1';
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController email;
  late TextEditingController phonenumber;
  late TextEditingController cartecin;
  late TextEditingController password;
  late TextEditingController confirmpassword;
  bool isShowpassword = true;
  StatusRequest statusRequest = StatusRequest.none;
  final SignupData signupData = SignupData(Get.find());
  List data = [];

  showPassword(){
    isShowpassword = isShowpassword == true ? false : true;
    update();
  }
  final box = GetStorage();
  @override
  void signUp() async {
    if (password.text != confirmpassword.text) {
      Get.snackbar(
        "60".tr,
        "64".tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.black,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(10),
        borderRadius: 12,
      );
      return;
    }

    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await signupData.postData(
          firstname.text,
          lastname.text,
          email.text,
          phonenumber.text,
          cartecin.text,
          password.text,
          confirmpassword.text,
          userType,
        );

        print("Full response: $response");

        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == "success") {
            String userEmail = email.text;

            await box.write('${userEmail}_firstName', firstname.text);
            await box.write('${userEmail}_lastName', lastname.text);
            await box.write('${userEmail}_email', email.text);
            await box.write('${userEmail}_phone', phonenumber.text);

            // Stocke aussi l'email courant pour savoir quel compte est connecté
            await box.write('current_user', userEmail);
            Get.offNamed(AppRoute.verifyCodesignup, arguments: {"email": email.text});
          } else {
            // Vérifie si l'email est déjà utilisé
            if (response['message'].toLowerCase().contains("déjà utilisé") ||
                response['message'].toLowerCase().contains("already used")) {
              Get.snackbar(
                "Erreur d'inscription".tr,
                "Cet email est déjà associé à un compte".tr,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                margin: const EdgeInsets.all(10),
                borderRadius: 8,
              );
            } else {
              Get.defaultDialog(
                title: "Warning".tr,
                middleText: response['message'] ?? "Signup failed".tr,
              );
            }
          }
        } else if (statusRequest == StatusRequest.offlinefailure) {
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
            middleText: "61".tr,
          );
        }
      } catch (e) {
        statusRequest = StatusRequest.serverfailure;
        Get.snackbar(
          "Erreur serveur".tr,
          "Une erreur est survenue: ${e.toString()}".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Signup error details: $e');
      } finally {
        update();
      }
    }
  }

  @override
  void goToSignIn() {
    Get.toNamed(AppRoute.login);
  }

  @override
  void goToSc() {
    Get.toNamed(AppRoute.verifyCodesignup);
  }

  @override
  void onInit() {
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phonenumber = TextEditingController();
    cartecin = TextEditingController();
    password = TextEditingController();
    confirmpassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    phonenumber.dispose();
    cartecin.dispose();
    password.dispose();
    confirmpassword.dispose();
    super.dispose();
  }
}