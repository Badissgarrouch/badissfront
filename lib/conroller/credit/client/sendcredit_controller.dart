import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/data/datasource/remote/credit/sendcredit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/function/handingdatacontroller.dart';
import '../../../core/constant/routes.dart';
import '../../../core/class/crud.dart';

abstract class SendOfferController extends GetxController {
  void sendOffer();
  void setStartDate(DateTime date);
}

class sendOfferControllerImp extends SendOfferController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController monthlySalary;
  late TextEditingController totalCredit;
  late TextEditingController duration;
  late TextEditingController startDate;
  late TextEditingController salaryPercentage;
  late TextEditingController purpose;
  late TextEditingController recipientName;
  late TextEditingController recipientEmail;
  late TextEditingController comment;

  final box = GetStorage();
  String selectedCurrency = 'TND';
  DateTime? selectedDate;

  StatusRequest statusRequest = StatusRequest.none;

  SendCreditData sendCreditData = SendCreditData(Crud());

  @override
  void onInit() {
    monthlySalary = TextEditingController();
    totalCredit = TextEditingController();
    duration = TextEditingController();
    startDate = TextEditingController();
    salaryPercentage = TextEditingController();
    purpose = TextEditingController();
    recipientName = TextEditingController();
    recipientEmail = TextEditingController();
    comment = TextEditingController();

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
    recipientName.dispose();
    recipientEmail.dispose();
    comment.dispose();

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
  void setStartDate(DateTime date) {
    selectedDate = date;
    startDate.text =
    "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    update();
  }

  @override
  void sendOffer() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      final token = box.read('token');

      try {
        if (selectedDate == null) {
          throw FormatException("Payment date not selected".tr);
        }

        var response = await sendCreditData.postData(
          monthlySalary: double.tryParse(monthlySalary.text) ?? 0,
          totalCredit: double.tryParse(totalCredit.text) ?? 0,
          devise: selectedCurrency,
          duration: int.tryParse(duration.text) ?? 0,
          startDate: selectedDate!,
          salaryPercentage: double.tryParse(salaryPercentage.text) ?? 0,
          purpose: purpose.text,
          recipientName: recipientName.text,
          recipientEmail: recipientEmail.text,
          comment: comment.text,
          token: token,
        );

        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            int offerId = response['data']['id'];
            // Clear all fields
            monthlySalary.clear();
            totalCredit.clear();
            duration.clear();
            startDate.clear();
            salaryPercentage.clear();
            purpose.clear();
            recipientName.clear();
            recipientEmail.clear();
            comment.clear();
            selectedDate = null;

            Get.snackbar(
              'SUCCESS'.tr,
              'Offer sent successfully'.tr,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.primaryBlue,
              colorText: Colors.white,
              margin: const EdgeInsets.all(40),
              borderRadius: 16,
              duration: const Duration(seconds: 2),
              isDismissible: true,
              forwardAnimationCurve: Curves.easeOutBack,
            );

            await Future.delayed(const Duration(seconds: 2));

            Get.toNamed(
              AppRoute.listSentOffer,
              arguments: {
                "offerId": offerId,
                "token": token
              },
            );
          } else {
            showErrorDialog(
                "Erreur", response['message'] ?? "Une erreur s'est produite");
          }
        } else {
          showErrorDialog(
              "Erreur", "Veuillez vérifier les informations saisies");
        }
      } on FormatException catch (e) {
        showErrorDialog(
            "Format invalide",
            e.message ?? "Veuillez vérifier le format des données saisies");
      } catch (e) {
        debugPrint('Erreur détaillée: $e');
        showErrorDialog("Erreur inattendue",
            "Une erreur technique s'est produite. Veuillez réessayer plus tard.");
      } finally {
        statusRequest = StatusRequest.none;
        update();
      }
    }
  }

  void updateSelectedCurrency(String currency) {
    selectedCurrency = currency;
    update();
  }
}