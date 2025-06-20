import 'package:credit_app/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:credit_app/conroller/auth/forgotpassword_controller.dart';
import 'package:credit_app/core/function/validinput.dart';
import 'package:credit_app/view/widget/auth/custombutton.dart';
import 'package:credit_app/view/widget/auth/customtextfield.dart';
import 'package:credit_app/view/widget/auth/customtexttitle.dart';
import 'package:credit_app/view/widget/auth/customtextbody.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordControllerImp controller = Get.put(ForgotPasswordControllerImp());

    return Scaffold(
      body: Center(
        child: Form(
          key: controller.formstate,
          child: SingleChildScrollView(
            child: GetBuilder<ForgotPasswordControllerImp>(
              builder: (controller) =>
              controller.statusRequest == StatusRequest.loading
                  ? Center(
                child: Lottie.asset(
                  'assets/lotties/loading.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animation Lottie centrée
                    SizedBox(
                      width: 250,
                      height: 200,
                      child: Lottie.asset(
                        'assets/lotties/check.json',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.lock_reset, size: 100, color: Colors.purple);
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Titre
                    Customtexttitle(text: "Check Email".tr),
                    const SizedBox(height: 15),

                    // Texte descriptif
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Customtextbody(text: "Please enter your email to receive a verification code".tr),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Champ Email
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 5, 100, "email");
                        },
                        mycontroller: controller.email,
                        hinttext: 'Enter Your Email'.tr,
                        labeltext: 'Email'.tr,
                        iconData: Icons.email_outlined,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Bouton
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Custombutton(
                        text: 'Check'.tr,
                        onPressed: () {
                          controller.checkEmail();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
