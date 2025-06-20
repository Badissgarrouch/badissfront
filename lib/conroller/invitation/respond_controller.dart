import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../../core/class/crud.dart';
import '../../../core/function/handingdatacontroller.dart';
import '../../linkapi.dart';

abstract class RespondController extends GetxController {
  goToRespond();
  acceptInvitation(String senderId);
  rejectInvitation(String senderId);
}

class RespondControllerImp extends RespondController {
  Crud crud = Crud();
  StatusRequest statusRequest = StatusRequest.none;
  final box = GetStorage();

  @override
  void goToRespond() {
    Get.toNamed(AppRoute.respondInvitation);
  }

  @override
  Future<void> acceptInvitation(String senderId) async {
    await respondToInvitation(senderId, 'accepted');
  }

  @override
  Future<void> rejectInvitation(String senderId) async {
    await respondToInvitation(senderId, 'rejected');
  }
  void defaultDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      onConfirm: () {
        Get.back();
      },
      textConfirm: 'OK',
      confirmTextColor: Colors.black,
      buttonColor: Colors.blue,
      radius: 10.0,
    );
  }

  Future<void> respondToInvitation(String senderId, String status) async {
    statusRequest = StatusRequest.loading;
    update();
    try {

      final token = await box.read('token');

      if (token == null) {
        defaultDialog('Erreur', 'Utilisateur non authentifié, veuillez vous connecter');
        return;
      }

      var response = await crud.patchData(
        '${AppLink.respondInvitation}/$senderId',
        {'status': status},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      response.fold(
            (failure) {
          statusRequest = failure;
          if (statusRequest == StatusRequest.offlinefailure) {
            Get.defaultDialog(
              title: "62".tr,
              middleText: "63".tr,
              backgroundColor: Colors.white,
              titleStyle: TextStyle(color: Colors.black),
              middleTextStyle: TextStyle(color: Colors.black),
              radius: 12,
              barrierDismissible: false,
            );
            return;
          } else {
            defaultDialog('Erreur', 'Problème de serveur. Veuillez réessayer plus tard.');
          }
        },
            (responseData) {
          statusRequest = StatusRequest.success;
          if (responseData['status'] == 'success') {
            Get.back();
            defaultDialog('Succès', status == 'accepted'
                ? 'Invitation acceptée avec succès'
                : 'Invitation rejetée avec succès');
          } else {
            defaultDialog('Erreur', responseData['message'] ?? 'Erreur lors du traitement');
          }
        },
      );

    } catch (e) {
      statusRequest = StatusRequest.serverexception;
      defaultDialog('Erreur', 'Une erreur est survenue: ${e.toString()}');
    }
    update();
  }
}
