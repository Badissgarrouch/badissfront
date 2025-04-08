import 'package:credit_app/conroller/auth/signup2_controller.dart';
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
import '../../widget/auth/textsignup.dart'; // Import du widget Textsignup

class Signup2 extends StatelessWidget {
  const Signup2({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUp2ControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: Text(
          '11'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<SignUp2ControllerImp>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        'assets/lotties/loading.json', // Chemin vers votre fichier JSON Lottie
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
                      Customtexttitle(text: "26".tr),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.28, // 25% de l'écran
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Lottie.asset(
                          'assets/lotties/signup.json',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Customtextbody(
                        text: "13".tr,
                      ),
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
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 5, 25, "address");
                        },
                        mycontroller: controller.businessaddress,
                        hinttext: '28'.tr,
                        labeltext: '27'.tr,
                        iconData: Icons.location_on,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 2, 15, "name");
                        },
                        mycontroller: controller.businessname,
                        hinttext: '30'.tr,
                        labeltext: '29'.tr,
                        iconData: Icons.business,
                      ),
                      const SizedBox(height: 5),
                      Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 2, 20, "activity");
                        },
                        mycontroller: controller.sectorofactivity,
                        hinttext: '32'.tr,
                        labeltext: '31'.tr,
                        iconData: Icons.factory,
                      ),
                      const SizedBox(height: 5),
                      GetBuilder<SignUp2ControllerImp>(builder: (controller) => Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 8, 30, "password");
                        },
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        mycontroller: controller.password,
                        obscureText: controller.isshowpassword,
                        hinttext: '21'.tr,
                        labeltext: '20'.tr,
                        iconData: Icons.lock_outline,
                      )),
                      const SizedBox(height: 5),
                      GetBuilder<SignUp2ControllerImp>(builder: (controller) => Customtextfield(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 8, 30, "password");
                        },
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        mycontroller: controller.confirmpassword,
                        obscureText: controller.isshowpassword,
                        hinttext: '23'.tr,
                        labeltext: '22'.tr,
                        iconData: Icons.key,
                      )),
                      const SizedBox(height: 7),
                      Custombutton(
                        text: '11'.tr,
                        onPressed: () {
                          controller.signUp2(); // Action pour l'inscription
                        },
                      ),
                      const SizedBox(height: 10),

                      // Section "Already have an account? Sign In"
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
