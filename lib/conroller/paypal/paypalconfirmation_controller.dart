import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/paypal.dart';

import '../../view/screen/paypal/paypalreussi.dart';
import '../../view/widget/paypal/paypalpaiment/paypal2.dart' as payment_service;


class PaymentConfirmationController extends GetxController with GetSingleTickerProviderStateMixin {
  final String paymentMethod;
  final PaymentData paymentData;
  final payment_service.PaymentService paymentService;
  final double amount;
  final isProcessing = false.obs;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  PaymentConfirmationController({
    required this.paymentMethod,
    required this.paymentData,
    required this.paymentService,
    required this.amount,
  });

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    ));
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void processPayment() async {
    isProcessing.value = true;
    animationController.repeat();

    try {
      payment_service.PaymentResult result;

      if (paymentMethod == 'paypal') {
        result = await paymentService.processPayPalPayment(paymentData, amount);
      } else {
        result = await paymentService.processPayment(paymentData, amount);
      }

      animationController.stop();

      if (result.isSuccess) {
        Get.off(() => PaymentSuccessScreen(
          transactionId: result.transactionId!,
          paymentMethod: paymentMethod,
        ));
      } else {
        isProcessing.value = false;
        // Log error silently or show dialog (no SnackBar per requirement)
        print('Payment error: ${result.message}');
        Get.dialog(
          AlertDialog(
            title: const Text('Erreur de paiement'),
            content: Text(result.message ?? 'Une erreur est survenue.'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      animationController.stop();
      isProcessing.value = false;
      print('Unexpected error: $e');
      Get.dialog(
        AlertDialog(
          title: const Text('Erreur'),
          content: Text('Erreur inattendue: $e'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}