import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() async {
  bool exitConfirmed = false;
  await Get.defaultDialog(
    title: "55".tr,
    middleText: "56".tr,
    confirm: ElevatedButton(
      onPressed: () {
        exitConfirmed = true;
        Get.back(); // Fermer la boîte de dialogue
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Fond bleu
        foregroundColor: Colors.white, // Texte blanc
      ),
      child:  Text("58".tr),
    ),
    cancel: ElevatedButton(
      onPressed: () {
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Fond bleu
        foregroundColor: Colors.white, // Texte blanc
      ),
      child:  Text("57".tr),
    ),
  );
  return exitConfirmed;
}
