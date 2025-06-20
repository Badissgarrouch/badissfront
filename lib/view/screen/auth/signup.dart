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
          'Sign Up'.tr,
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
                      Customtexttitle(text: "Customers Registration".tr),
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
                      Customtextbody(text: "Fill out the form with your information to create your account".tr),
                      const SizedBox(height: 20),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!,3,20,"username");
                        },
                        mycontroller: controller.firstname,
                        hinttext: 'Enter Your First Name'.tr,
                        labeltext: 'First Name'.tr,
                        iconData: Icons.person,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!,3,20,"username");
                        },
                        mycontroller: controller.lastname,
                        hinttext: 'Enter Your Last Name'.tr,
                        labeltext: 'Last Name'.tr,
                        iconData: Icons.person_outline,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!,10,40,"email");
                        },
                        mycontroller: controller.email,
                        hinttext: 'Enter Your Email'.tr,
                        labeltext: 'Email'.tr,
                        iconData: Icons.email_outlined,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: true,
                        valid: (val) {
                          return validInput(val!,8,20,"phone");
                        },
                        mycontroller: controller.phonenumber,
                        hinttext: 'Enter Your Phone Number'.tr,
                        labeltext: 'Phone Number'.tr,
                        iconData: Icons.phone_iphone,
                      ),
                      // Après le champ phone
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: true,
                        valid: (val) {
                          return validInput(val!,8,13,"cin");
                        },
                        mycontroller: controller.cartecin,
                        hinttext: 'Enter your CIN number'.tr,
                        labeltext: 'CIN'.tr,
                        iconData: Icons.credit_card_outlined,
                      ),
                      // Après le champ phone
                      const SizedBox(height: 5),

                      GetBuilder<SignUpControllerImp>(
                        builder: (controller) => Customtextfield(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!,8,40,"password");
                          },
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          obscureText: controller.isShowpassword,
                          mycontroller: controller.password,
                          hinttext: 'Enter Your Password'.tr,
                          labeltext: 'Password'.tr,
                          iconData: Icons.lock_outline,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GetBuilder<SignUpControllerImp>(
                        builder: (controller) => Customtextfield(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!,8,40,"password");
                          },
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          obscureText: controller.isShowpassword,
                          mycontroller: controller.confirmpassword,
                          hinttext: 'Enter to confirm Password'.tr,
                          labeltext: 'Confirm Password'.tr,
                          iconData: Icons.key,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Custombutton(
                        text: 'Sign Up'.tr,
                        onPressed: () {
                          controller.signUp();
                        },
                      ),
                      const SizedBox(height: 10),
                      Textsignup(
                        textone: "Already have an account?".tr,
                        texttwo: "Sign In".tr,
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
