import 'package:credit_app/conroller/auth/resetpassword_controller.dart';
import 'package:credit_app/core/function/validinput.dart';
import 'package:credit_app/view/widget/auth/custombutton.dart';
import 'package:credit_app/view/widget/auth/customtextfield.dart';
import 'package:credit_app/view/widget/auth/customtexttitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../widget/auth/customtextbody.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordControllerImp controller = Get.put(ResetPasswordControllerImp());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Animation Lottie (inchangée)
            SizedBox(
              height: 300,
              child: Lottie.asset(
                'assets/lotties/new.json',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),

            // 2. Titre déplacé ICI (juste après la Lottie)
            // Espacement réduit

            // 3. Le reste du code EXACTEMENT comme avant
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Customtexttitle(text: "44".tr), // "New Password"
                  const SizedBox(height: 10),
                  Customtextbody(text: "45".tr),
                  const SizedBox(height: 10),

                  GetBuilder<ResetPasswordControllerImp>(builder: (controller)=>Customtextfield(
                    isNumber: false,
                    valid: (val){ return validInput(val!, 8, 25,"password"); },
                    onTapIcon: (){ controller.showPassword(); },
                    mycontroller: controller.newPasswordController,
                    obscureText: controller.isShowPassword,
                    hinttext: '21'.tr,
                    labeltext: '20'.tr,
                    iconData: Icons.key_off,
                  )),

                  const SizedBox(height: 2),

                  GetBuilder<ResetPasswordControllerImp>(builder: (controller)=>Customtextfield(
                    isNumber: false,
                    valid: (val){ return validInput(val!, 8, 25, "password"); },
                    onTapIcon: (){ controller.showPassword(); },

                    mycontroller: controller.confirmPasswordController,
                    obscureText: controller.isShowPassword,
                    hinttext: '46'.tr,
                    labeltext: '47'.tr,
                    iconData: Icons.key,
                  )),

                  const SizedBox(height: 10),

                  GetBuilder<ResetPasswordControllerImp>(builder: (controller)=>Custombutton(
                    text: '48'.tr,
                    onPressed: () { controller.resetPassword(); },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}