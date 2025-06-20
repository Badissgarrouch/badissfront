import 'dart:async';
import 'dart:math';

import 'package:credit_app/data/model/paypal.dart';
import 'package:get/get.dart';

enum PaymentStatus {
  idle,
  processing,
  success,
  error,
}

class PaymentResult {
  final PaymentStatus status;
  final String? message;
  final String? transactionId;

  PaymentResult({
    required this.status,
    this.message,
    this.transactionId,
  });

  bool get isSuccess => status == PaymentStatus.success;
  bool get isError => status == PaymentStatus.error;
  bool get isProcessing => status == PaymentStatus.processing;
}

class PaymentService {
  PaymentService();

  Future<PaymentResult> processPayment(PaymentData paymentData, double amount) async {
    if (!validateCardNumber(paymentData.cardNumber ?? '')) {
      return PaymentResult(
        status: PaymentStatus.error,
        message: 'Invalid card number'.tr,
      );
    }
    if (!validateExpiryDate(paymentData.expiryDate ?? '')) {
      return PaymentResult(
        status: PaymentStatus.error,
        message: 'Invalid expiration date'.tr,
      );
    }

    await Future.delayed(const Duration(seconds: 2));

    final random = Random();
    final success = random.nextDouble() > 0.1;

    if (success) {
      return PaymentResult(
        status: PaymentStatus.success,
        message: 'Card payment successfully completed'.tr,
        transactionId: _generateTransactionId(),
      );
    } else {
      return PaymentResult(
        status: PaymentStatus.error,
        message: 'Error processing card payment.'.tr,
      );
    }
  }

  Future<PaymentResult> processPayPalPayment(PaymentData paymentData, double amount) async {
    if (!paymentData.isPayPalDataValid) {
      return PaymentResult(
        status: PaymentStatus.error,
        message: 'Invalid PayPal credentials'.tr,
      );
    }

    await Future.delayed(const Duration(seconds: 3));

    final random = Random();
    final success = random.nextDouble() > 0.05;

    if (success) {
      return PaymentResult(
        status: PaymentStatus.success,
        message: 'PayPal payment made successfully'.tr,
        transactionId: _generateTransactionId(),
      );
    } else {
      return PaymentResult(
        status: PaymentStatus.error,
        message: 'Error processing PayPal payment.'.tr,
      );
    }
  }

  String _generateTransactionId() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return 'CMD-2025-${List.generate(8, (index) => chars[random.nextInt(chars.length)]).join()}';
  }

  bool validateCardNumber(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(' ', '');
    if (cleanNumber.length < 13 || cleanNumber.length > 19) return false;

    int sum = 0;
    bool alternate = false;

    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanNumber[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  bool validateExpiryDate(String expiryDate) {
    if (expiryDate.length != 5 || !expiryDate.contains('/')) return false;

    final parts = expiryDate.split('/');
    if (parts.length != 2) return false;

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return false;
    if (month < 1 || month > 12) return false;

    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return false;
    }

    return true;
  }
}