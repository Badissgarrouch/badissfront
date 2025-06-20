
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/auth/successpagereset_controller.dart';

class SuccesspageReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SuccesspageResetControllerImp controller = Get.put(SuccesspageResetControllerImp());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(2, 4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SUCCESS'.tr,
                      style: TextStyle(
                        fontSize: 36, // Très grand texte
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Gris clair
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    // ✅ Icône de validation
                    Icon(
                      Icons.check_circle,
                      size: 90,
                      color: Colors.white,
                    ),
                    SizedBox(height: 15),

                    // ✅ Texte "Congratulations"
                    Text(
                      'Congratulations!'.tr,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'password is changed'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),

                    // ✅ Bouton "Go to Sign In"
                    ElevatedButton(
                      onPressed: () {
                        controller.goToLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Go to Sign In'.tr,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
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
