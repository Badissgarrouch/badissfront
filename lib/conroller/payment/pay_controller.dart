import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../../core/class/crud.dart';
import '../../data/datasource/remote/payment/getmerchantcard.dart';

abstract class ClientPaymentController extends GetxController {}

class ClientPaymentControllerImp extends ClientPaymentController {
  final MerchantCardService merchantCardService = MerchantCardService(Crud());
  final PaymentService paymentService = PaymentService(Crud());
  Crud crud = Crud();
  final box = GetStorage();

  late final String token;
  late final String merchantId;

  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);
  var receiptImage = Rx<File?>(null);
  var currentStep = 0.obs;
  var selectedCard = Rx<Map<String, dynamic>?>(null);
  var availableCards = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    token = box.read('token') ?? '';
    merchantId = Get.arguments['merchantId'] ?? '';
    loadMerchantCards();
  }

  Future<void> loadMerchantCards() async {
    try {
      if (merchantId.isEmpty || token.isEmpty) {
        Get.snackbar('Erreur', 'Informations manquantes');
        return;
      }

      isLoading.value = true;
      final response = await merchantCardService.getMerchantCards(
        merchantId: merchantId,
        token: token,
      );

      response.fold(
            (failure) {
          Get.snackbar('Erreur', 'Impossible de charger les cartes');
        },
            (cards) {
          availableCards.value = cards;
          if (cards.isNotEmpty) {
            selectedCard.value = cards.first;
          } else {
            Get.snackbar('Information', 'Aucune carte disponible pour ce marchand');
          }
        },
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Une erreur est survenue: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitPayment() async {
    try {
      if (receiptImage.value == null || !await receiptImage.value!.exists()) {
        Get.snackbar('Erreur', 'Le reçu sélectionné est invalide');
        return;
      }

      isLoading.value = true;

      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
      final formattedTime = selectedTime.value!.format(Get.context!);

      final response = await paymentService.post2Data(
        token: token,
        merchantId: merchantId,
        cardType: selectedCard.value!['cardType'],
        cardNumber: selectedCard.value!['cardNumber'],
        receiptImage: receiptImage.value!,
        paymentDate: formattedDate,
        paymentTime: formattedTime,
      );

      response.fold(
            (failure) {
          Get.snackbar('Erreur', 'Échec de l\'enregistrement du paiement');
        },
            (response) {
          if (response['success'] == true) {
            Get.snackbar('Succès', 'Paiement enregistré avec succès');
          } else {
            Get.snackbar('Erreur', response['message'] ?? 'Erreur inconnue');
          }
        },
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Une erreur est survenue: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (await file.exists()) {
          receiptImage.value = file;
        } else {
          Get.snackbar('Erreur', 'Impossible d\'accéder au fichier');
        }
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de sélectionner l\'image: $e');
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
  }
}