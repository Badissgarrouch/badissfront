import 'package:credit_app/conroller/auth/signup_controller.dart';
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/validinput.dart';

import 'package:credit_app/view/widget/auth/custombutton.dart';
import 'package:credit_app/view/widget/auth/customtextfield.dart';
import 'package:credit_app/view/widget/auth/customtexttitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../widget/auth/customtextbody.dart';
import '../../widget/auth/textsignup.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: Text(
          '11'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<SignUpControllerImp>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        'assets/lotties/loading.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: controller.formstate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Customtexttitle(text: "12".tr),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Lottie.asset(
                          'assets/lotties/signup.json',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Customtextbody(text: "13".tr),
                      const SizedBox(height: 20),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 3, 20, "username");
                        },
                        mycontroller: controller.firstname,
                        hinttext: '15'.tr,
                        labeltext: '14'.tr,
                        iconData: Icons.person,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 3, 20, "username");
                        },
                        mycontroller: controller.lastname,
                        hinttext: '101'.tr,
                        labeltext: '100'.tr,
                        iconData: Icons.person_outline,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 10, 40, "email");
                        },
                        mycontroller: controller.email,
                        hinttext: '17'.tr,
                        labeltext: '16'.tr,
                        iconData: Icons.email_outlined,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: true,
                        valid: (val) {
                          return validInput(val!, 8, 20, "phone");
                        },
                        mycontroller: controller.phonenumber,
                        hinttext: '19'.tr,
                        labeltext: '18'.tr,
                        iconData: Icons.phone_iphone,
                      ),
                      // Après le champ phone
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: true,
                        valid: (val) {
                          return validInput(val!, 12, 20, "cin");
                        },
                        mycontroller: controller.cartecin,
                        hinttext: '77'.tr,
                        labeltext: '76'.tr,
                        iconData: Icons.credit_card_outlined,
                      ),
                      // Après le champ phone
                      const SizedBox(height: 5),

                      GetBuilder<SignUpControllerImp>(
                        builder: (controller) => Customtextfield(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 8, 40, "password");
                          },
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          obscureText: controller.isShowpassword,
                          mycontroller: controller.password,
                          hinttext: '21'.tr,
                          labeltext: '20'.tr,
                          iconData: Icons.lock_outline,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GetBuilder<SignUpControllerImp>(
                        builder: (controller) => Customtextfield(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 8, 40, "password");
                          },
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          obscureText: controller.isShowpassword,
                          mycontroller: controller.confirmpassword,
                          hinttext: '23'.tr,
                          labeltext: '22'.tr,
                          iconData: Icons.key,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Custombutton(
                        text: '11'.tr,
                        onPressed: () {
                          controller.signUp();
                        },
                      ),
                      const SizedBox(height: 10),
                      Textsignup(
                        textone: "24".tr,
                        texttwo: "25".tr,
                        onTap: () {
                          controller.goToSignIn();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
