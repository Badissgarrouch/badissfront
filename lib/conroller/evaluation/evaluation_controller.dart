import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/component/evaluationdialog.dart';
import '../../data/datasource/remote/evaluation/evaluation.dart';

class EvaluationController extends GetxController {
  final RxMap<String, String> emojiResponses = {
    'credit_communication': '🙂',
    'payment_timeliness': '🙂',
    'transaction_professionalism': '🙂',
  }.obs;

  final RxMap<String, int> starResponses = {
    'credit_communication': 3,
    'payment_timeliness': 3,
    'transaction_professionalism': 3,
  }.obs;

  final RxBool isSubmitting = false.obs;
  final RxString clientName = ''.obs;

  final List<Map<String, String>> questions = [
    {
      'id': 'credit_communication',
      'text': 'Communication on credits'.tr,
      'description': 'Clarity in discussions on the terms and conditions of credits'.tr
    },
    {
      'id': 'payment_timeliness',
      'text': 'Punctuality of payments'.tr,
      'description': 'Compliance with credit repayment deadlines'.tr
    },
    {
      'id': 'transaction_professionalism',
      'text': 'Professionalism of transactions'.tr,
      'description': 'Competence and seriousness in the management of credit transactions'.tr
    },
  ];

  late EvaluationData evaluationData;
  String? token;

  int get totalStars => starResponses.values.reduce((a, b) => a + b);
  double get averageStars => totalStars / starResponses.length;
  bool get isFormValid => clientName.value.isNotEmpty && starResponses.values.every((stars) => stars > 0);

  @override
  void onInit() {
    evaluationData = EvaluationData(Get.find());
    token = Get.arguments['token'];
    super.onInit();
  }

  void changeEmoji(String questionId, String newEmoji) {
    emojiResponses[questionId] = newEmoji;
    switch (newEmoji) {
      case '😊':
        starResponses[questionId] = 4;
        break;
      case '🙂':
        starResponses[questionId] = 3;
        break;
      case '😞':
        starResponses[questionId] = 1;
        break;
    }
  }

  void changeStars(String questionId, int stars) {
    starResponses[questionId] = stars;
    if (stars >= 4) {
      emojiResponses[questionId] = '😊';
    } else if (stars >= 2) {
      emojiResponses[questionId] = '🙂';
    } else {
      emojiResponses[questionId] = '😞';
    }
  }

  Future<void> submitEvaluation() async {
    if (isSubmitting.value || !isFormValid) {
      if (!isFormValid) {
        Get.snackbar(
          'Erreur',
          'Veuillez remplir le nom du client et répondre à toutes les questions.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(16),
        );
      }
      return;
    }

    isSubmitting.value = true;

    try {
      final nameParts = clientName.value.trim().split(' ');
      final firstName = nameParts[0];
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final response = await evaluationData.submitEvaluation(
        receiverFirstName: firstName,
        receiverLastName: lastName,
        creditCommunicationStars: starResponses['credit_communication']!,
        paymentTimelinessStars: starResponses['payment_timeliness']!,
        transactionProfessionalismStars: starResponses['transaction_professionalism']!,
        token: token!,
      );

      response.fold(
            (failure) {
          String errorMessage;
          switch (failure) {
            case StatusRequest.offlinefailure:
              errorMessage = 'Pas de connexion Internet.';
              break;
            case StatusRequest.authfailure:
              errorMessage = 'Session expirée. Veuillez vous reconnecter.';
              Get.offNamed('/login');
              break;
            case StatusRequest.serverfailure:
              errorMessage = 'Name or first name incorrect'.tr;
              break;
            case StatusRequest.serverexception:
              errorMessage = 'Une erreur inattendue s\'est produite.';
              break;
            default:
              errorMessage = 'Échec de la soumission de l\'évaluation.';
          }
          Get.snackbar(
            'Error'.tr,
            errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        },
            (success) {
          Get.dialog(
            EvaluationDialog(
              totalStars: totalStars,
              averageStars: averageStars,
            ),
          );
        },
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Erreur lors de la soumission : $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}