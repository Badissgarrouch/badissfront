import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() async {
  bool exitConfirmed = false;
  await Get.defaultDialog(
    title: "Attention".tr,
    middleText: "You want to exit the application".tr,
    confirm: ElevatedButton(
      onPressed: () {
        exitConfirmed = true;
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child:  Text("Confirm".tr),
    ),
    cancel: ElevatedButton(
      onPressed: () {
        Get.back();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child:  Text("Cancel".tr),
    ),
  );
  return exitConfirmed;
}
