
import 'package:credit_app/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasource/remote/evaluation/evaluation.dart';

class ReceivedEvaluationsController extends GetxController {
  final EvaluationData evaluationData = Get.find<EvaluationData>();
  final RxList<Map<String, dynamic>> evaluations = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredEvaluations = <Map<String, dynamic>>[].obs;
  final Rx<StatusRequest> status = StatusRequest.none.obs;
  final RxString selectedFilter = 'all'.obs;
  final String? token;

  ReceivedEvaluationsController({this.token});

  @override
  void onInit() {
    fetchReceivedEvaluations();
    super.onInit();
  }

  Future<void> fetchReceivedEvaluations() async {
    if (token == null) {
      status.value = StatusRequest.authfailure;
      Get.snackbar(
        'Erreur',
        'Session expirée. Veuillez vous reconnecter.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    print('Using token: $token');
    status.value = StatusRequest.loading;

    final response = await evaluationData.getReceivedEvaluations(token: token!);

    response.fold(
          (failure) {
        status.value = failure;
        _handleError(failure);
      },
          (success) {
        print(success);
        evaluations.value = List<Map<String, dynamic>>.from(success['data']['evaluations']);
        filterEvaluations(selectedFilter.value);
        status.value = StatusRequest.success;
      },
    );
  }

  void _handleError(StatusRequest failure) {
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
        errorMessage = 'Erreur serveur. Veuillez réessayer.';
        break;
      case StatusRequest.serverexception:
        errorMessage = 'Une erreur inattendue s\'est produite.';
        break;
      default:
        errorMessage = 'Échec de la récupération des évaluations.';
    }
    Get.snackbar(
      'Erreur',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  void filterEvaluations(String filter) {
    selectedFilter.value = filter;

    if (filter == 'all') {
      filteredEvaluations.value = evaluations;
      return;
    }

    filteredEvaluations.value = evaluations.where((eval) {
      return eval['satisfactionStatus'] == filter;
    }).toList();
  }
}