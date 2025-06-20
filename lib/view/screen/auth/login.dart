import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/alertexitapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/conroller/auth/login_contoller.dart';
import 'package:credit_app/core/constant/routes.dart';
import 'package:credit_app/core/function/validinput.dart';
import 'package:credit_app/view/widget/auth/custombutton.dart';
import 'package:credit_app/view/widget/auth/customtextfield.dart';
import 'package:credit_app/view/widget/auth/customtexttitle.dart';
import 'package:credit_app/view/widget/auth/textsignup.dart';
import 'package:lottie/lottie.dart';
import '../../widget/auth/customtextbody.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: Text(
          'Sign In'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return await alertExitApp();
        },
        child: SingleChildScrollView(
          child: GetBuilder<LoginControllerImp>(
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
                        Customtexttitle(text: "Welcome Back".tr),
                        const SizedBox(height: 5),
                        const CircleAvatar(
                          radius: 110,
                          backgroundImage: AssetImage("assets/images/lololo.png"),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(height: 1),
                        Customtextbody(text: "Sign in with your email and password".tr),
                        const SizedBox(height: 20),
                        Customtextfield(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 10, 40, 'email');
                          },
                          mycontroller: controller.email,
                          hinttext: 'Enter Your Email'.tr,
                          labeltext: 'Email'.tr,
                          iconData: Icons.email_outlined,
                        ),
                        const SizedBox(height: 5),
                        GetBuilder<LoginControllerImp>(
                          builder: (controller) {
                            return Customtextfield(
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 8, 30, 'password');
                              },
                              onTapIcon: () {
                                controller.showPassword();
                              },
                              mycontroller: controller.password,
                              obscureText: controller.isshowpassword,
                              hinttext: 'Enter Your Password'.tr,
                              labeltext: 'Password'.tr,
                              iconData: Icons.lock_outline,
                            );
                          },
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoute.forgotPassword);
                              },
                              child: Text(
                                "Forgot Password?".tr,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Custombutton(
                          text: 'Sign In'.tr,
                          onPressed: () {
                            controller.login();
                          },
                        ),
                        const SizedBox(height: 10),
                        Textsignup(
                          textone: "You don't have an account yet!".tr,
                          texttwo: "Sign Up".tr,
                          onTap: () {
                            controller.goTosignup();
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
      ),
    );
  }
}
