import 'package:credit_app/conroller/auth/verifycode_controller.dart';
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/view/widget/auth/customtextbody.dart';
import 'package:credit_app/view/widget/auth/customtexttitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Verifycode extends StatelessWidget {
  const Verifycode({super.key});

  @override
  Widget build(BuildContext context) {
    VerifycodeControllerImp controller = Get.put(VerifycodeControllerImp());

    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc pour toute la page
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<VerifycodeControllerImp>(
            builder: (controller) {
              if (controller.statusRequest == StatusRequest.loading) {
                return Center(
                    child: Lottie.asset(
                      'assets/lotties/loading.json', // Chemin vers votre fichier JSON Lottie
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ));
              }
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animation Lottie avec fond transparent
                    SizedBox(
                      width: 270,
                      height: 240,
                      child: Lottie.asset(
                        'assets/lotties/otp.json',
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 30),
                    Customtexttitle(text: "41".tr),
                    const SizedBox(height: 20),

                    // Texte centré
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "42".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Champs OTP
                    OtpTextField(
                      fieldWidth: 45,
                      borderRadius: BorderRadius.circular(12),
                      numberOfFields: 5,
                      borderColor: Colors.blue,
                      focusedBorderColor: Colors.blueAccent,
                      showFieldAsBox: true,
                      onSubmit: (String verificationCode) {
                        controller.goToResetPassword(verificationCode);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}