import 'package:credit_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:credit_app/core/function/handingdatacontroller.dart';

import '../../../core/class/crud.dart';
import '../../../core/constant/colors.dart';
import '../../../data/datasource/remote/credit/checkoffre.dart';
import '../../../data/datasource/remote/credit/respondoffer.dart';

abstract class CheckOfferController extends GetxController {
  void fetchOffers();

}

class CheckOfferControllerImp extends CheckOfferController {
  final CheckOfferData checkOfferData = CheckOfferData(Crud());
  final RespondOfferData respondOfferData = RespondOfferData(Crud());


  final box = GetStorage();

  StatusRequest statusRequest = StatusRequest.none;
  List<dynamic> offers = [];

  @override
  void onInit() {
    fetchOffers();
    super.onInit();
  }

  Future<void> fetchOffers() async {
    statusRequest = StatusRequest.loading;
    update();

    final token = box.read('token');

    try {
      var response = await checkOfferData.getData(token: token);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          offers = response['data'];
        } else {
          Get.snackbar('Erreur', response['message'] ?? "Erreur inconnue");
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.serverfailure;
      Get.snackbar('Erreur', 'Une erreur est survenue: ${e.toString()}');
    }
    update();
  }

  Future<void> respondToOffer({
    required String offerId,
    required String action,
    String? comment,
  }) async {
    statusRequest = StatusRequest.loading;
    update();

    final token = box.read('token');

    try {
      var response = await respondOfferData.postData(
        token: token,
        offerId: offerId,
        action: action,
        comment: comment,
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          final index = offers.indexWhere((o) => o['id']?.toString() == offerId);
          if (index != -1) {
            offers[index] = {
              ...offers[index],
              'status': response['data']['newStatus'],
              'modificationStatus': response['data']['modificationStatus'],
              'respondedAt': DateTime.now().toIso8601String(),
            };
            update();
          }


          String title = 'SUCCESS';
          String message;

          switch (action.toLowerCase()) {
            case 'accept':
              message = 'Offer accepted'.tr;
              break;
            case 'reject':
              message = 'Offer rejected'.tr;
              break;
            case 'request_modification':
              message = 'Change request has been sent'.tr;
              break;
            default:
              message = response['message'] ?? 'Action performed'.tr;
          }


          Get.snackbar(
            title,
            message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primaryDark,
            colorText: Colors.white,
            margin: const EdgeInsets.all(20),
            borderRadius: 8,
            duration: const Duration(seconds: 2),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );

          await Future.delayed(const Duration(seconds: 2));
          Get.offNamed(AppRoute.offrelistScreen);
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.serverfailure;
    }
    update();
  }}