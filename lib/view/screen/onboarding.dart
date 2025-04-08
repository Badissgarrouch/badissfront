import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/core/constant/routes.dart';
import 'package:lottie/lottie.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
             Text(textAlign: TextAlign.center,
              '6'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 5),
            Lottie.asset(
              'assets/lotties/access.json',
              width: 300,
              height: 350,
              fit: BoxFit.contain,
              repeat: true, // L'animation se répète en boucle
              animate: true, // L'animation joue automatiquement
            ),
            const SizedBox(height: 20),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "7".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: MaterialButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoute.signUp);
                      },
                      child:  Text(
                        '8'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: MaterialButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoute.signUp2);
                      },
                      child: Text(
                        '9'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.languages); // 🔥 Aller à la page Languages
                  },
                  child:  Text(
                    "10".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
