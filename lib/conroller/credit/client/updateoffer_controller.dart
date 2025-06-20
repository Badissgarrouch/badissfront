import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/function/handingdatacontroller.dart';
import '../../../core/constant/routes.dart';
import '../../../core/class/crud.dart';
import '../../../data/datasource/remote/credit/updateoffer.dart';

abstract class UpdateOfferController extends GetxController {
  void updateOffer();
}

class UpdateOfferControllerImp extends UpdateOfferController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController monthlySalary;
  late TextEditingController totalCredit;
  late TextEditingController duration;
  late TextEditingController startDate;
  late TextEditingController salaryPercentage;
  late TextEditingController purpose;
  late TextEditingController modificationRequest;

  String selectedCurrency = 'TND';

  final box = GetStorage();
  StatusRequest statusRequest = StatusRequest.none;
  late Map<String, dynamic> offerData;
  UpdateOfferData updateOfferData = UpdateOfferData(Crud());

  @override
  void onInit() {
    if (Get.arguments == null || Get.arguments['offerData'] == null) {
      Get.back();
      Get.snackbar("Erreur", "Données de l'offre manquantes");
      return;
    }

    offerData = Get.arguments['offerData'];
    monthlySalary = TextEditingController(text: offerData['monthlySalary']?.toString() ?? '');
    totalCredit = TextEditingController(text: offerData['totalCredit']?.toString() ?? '');
    duration = TextEditingController(text: offerData['duration']?.toString() ?? '');
    startDate = TextEditingController(text: offerData['startDate']?.toString() ?? '');
    salaryPercentage = TextEditingController(text: offerData['salaryPercentage']?.toString() ?? '');
    purpose = TextEditingController(text: offerData['purpose'] ?? '');
    modificationRequest = TextEditingController(text: offerData['modificationRequest'] ?? '');


    super.onInit();
  }

  @override
  void dispose() {
    monthlySalary.dispose();
    totalCredit.dispose();
    duration.dispose();
    startDate.dispose();
    salaryPercentage.dispose();
    purpose.dispose();
    modificationRequest.dispose();
    super.dispose();
  }

  void showErrorDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }


  @override
  void updateOffer() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      final token = box.read('token');


      try {
        // Validation de la date
        final dateParts = startDate.text.split('/');
        if (dateParts.length != 3) {
          throw FormatException("Invalid date format".tr);
        }

        final day = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final year = int.parse(dateParts[2]);

        final parsedDate = DateTime(year, month, day);



        var response = await updateOfferData.putData(
          offerId: offerData['id'],
          monthlySalary: double.tryParse(monthlySalary.text) ?? 0,
          totalCredit: double.tryParse(totalCredit.text) ?? 0,
          devise: selectedCurrency,
          duration: int.tryParse(duration.text) ?? 0,
          startDate: parsedDate,
          salaryPercentage: double.tryParse(salaryPercentage.text) ?? 0,
          purpose: purpose.text,
          token: token,
        );

        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            await Future.delayed(const Duration(seconds: 3));
            Get.toNamed(AppRoute.listSentOffer, arguments: {
              "message": "The offer has been successfully modified".tr,
              "isUpdate": true,
            });
          } else {
            showErrorDialog(
                "Erreur",
                response['message'] ?? "Une erreur inconnue est survenue"
            );
          }
        } else {
          showErrorDialog(
              "Erreur de connexion",
              "Impossible de se connecter au serveur. Veuillez réessayer plus tard."
          );
        }
      } catch (e) {
        showErrorDialog(
            "Erreur inattendue",
            "Une erreur inattendue s'est produite. Veuillez réessayer."
        );
      } finally {
        update();
      }
    }
  }
  void updateSelectedCurrency(String currency) {
    selectedCurrency = currency;
    update();
  }
}