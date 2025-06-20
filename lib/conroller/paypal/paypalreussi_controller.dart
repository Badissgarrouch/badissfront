import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../view/screen/paypal/paypalcommande.dart';

class PaymentSuccessController extends GetxController with GetTickerProviderStateMixin {
  final String transactionId;
  final String paymentMethod;
  final double amount;
  late AnimationController checkAnimationController;
  late AnimationController confettiAnimationController;
  late Animation<double> checkAnimation;
  late Animation<double> scaleAnimation;

  PaymentSuccessController({
    required this.transactionId,
    required this.paymentMethod,
    required this.amount,
  });

  @override
  void onInit() {
    super.onInit();
    checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    confettiAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    checkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: checkAnimationController,
      curve: Curves.elasticOut,
    ));
    scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: checkAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    checkAnimationController.forward();
    // confettiAnimationController.forward(); // Placeholder for confetti effect (e.g., ConfettiWidget)
    HapticFeedback.lightImpact();
  }

  @override
  void onClose() {
    checkAnimationController.dispose();
    confettiAnimationController.dispose();
    super.onClose();
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year}, ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return months[month - 1];
  }

  void viewOrder() {
    Get.to(() => OrderDetailsScreen(
      transactionId: transactionId,
      paymentMethod: paymentMethod, amount:34.25,
    ));
  }

  void returnToHome() {
    Get.offAllNamed('/home');
  }
}