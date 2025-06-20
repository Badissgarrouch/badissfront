import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/handingdatacontroller.dart';
import 'package:credit_app/data/datasource/remote/auth/signup2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../core/constant/routes.dart';

abstract class SignUpController2 extends GetxController {
  void signUp2();
  void goToSignIn();
  void goToSc();
}

class SignUp2ControllerImp extends SignUpController2 {
  String userType = '2';
  GlobalKey<FormState> formstate=GlobalKey<FormState>();
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController email;
  late TextEditingController phonenumber;
  late TextEditingController cartecin;
  late TextEditingController businessaddress;
  late TextEditingController businessname;
  late TextEditingController sectorofactivity;
  late TextEditingController password;
  late TextEditingController confirmpassword;
  bool isshowpassword=true;
  final Signup2Data signup2Data = Signup2Data(Get.find());
  StatusRequest? statusRequest;

  showPassword(){
    isshowpassword=isshowpassword== true ? false :true;
    update();
  }
  final box = GetStorage();

  @override
  void signUp2() async {
    if (password.text != confirmpassword.text) {
      Get.snackbar(
        "⚠ Attention".tr,
        "Password do not match".tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.black,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await signup2Data.postData(
          firstname.text,
          lastname.text,
          email.text,
          phonenumber.text,
          cartecin.text,
          businessaddress.text,
          businessname.text,
          sectorofactivity.text,
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
            await box.write('${userEmail}_businessName', businessname.text);
            await box.write('${userEmail}_businessAddress',businessaddress.text);
            await box.write('${userEmail}_sectorofactivity',sectorofactivity.text);

            // Stocke aussi l'email courant pour savoir quel compte est connecté
            await box.write('current_user', userEmail);
            Get.offNamed(AppRoute.verifyCodesignup, arguments: {"email": email.text});
          } else {
            if (response['message'].toLowerCase().contains("déjà utilisé") ||
                response['message'].toLowerCase().contains("already used")) {
              Get.snackbar(
                "⚠ Attention".tr,
                "email is already used".tr,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                margin: const EdgeInsets.all(10),
                borderRadius: 8,
              );

              firstname.clear();
              lastname.clear();
              email.clear();
              phonenumber.clear();
              cartecin.clear();
              businessaddress.clear();
              businessname.clear();
              sectorofactivity.clear();
              password.clear();
              confirmpassword.clear();
              update();
            } else {
              Get.defaultDialog(
                title: "Warning".tr,
                middleText: response['message'] ?? "Signup failed".tr,
              );
            }
          }
        } else if (statusRequest == StatusRequest.offlinefailure) {
          Get.defaultDialog(
            title: "❌network error🌐".tr,
            middleText: "Please check your internet connection".tr,
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black),
            middleTextStyle: TextStyle(color: Colors.black),
            radius: 12,
            barrierDismissible: false,
          );
        } else {
          Get.defaultDialog(
            title: "⚠ Attention".tr,
            middleText: "email is already used".tr,
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
    businessaddress=TextEditingController();
    businessname=TextEditingController();
    sectorofactivity=TextEditingController();
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
    businessaddress.dispose();
    businessname.dispose();
    sectorofactivity.dispose();
    password.dispose();
    confirmpassword.dispose();
    super.dispose();
  }
}