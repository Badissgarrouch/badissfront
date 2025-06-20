import 'package:credit_app/core/constant/routes.dart';
import 'package:credit_app/core/localization/changedlocal.dart';
import 'package:credit_app/view/widget/languages/customerbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Languages extends GetView<LocaleController> {
  const Languages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/language.png",
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'Select your preferred language'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomerButton(textButton: 'English'.tr, onPressed: () {
              controller.changeLang("en");
            }),
            const SizedBox(height: 10),
            CustomerButton(textButton: 'French'.tr, onPressed: () {
              controller.changeLang("fr");
            }),
            const SizedBox(height: 10),
            CustomerButton(textButton: 'Arabic'.tr, onPressed: () {
              controller.changeLang("ar");
            }),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Get.offNamed(AppRoute.onBoarding);
                },
                child: Text(
                  "Next".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}