import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../conroller/paypal/paypalconfirmation_controller.dart';
import '../../../data/model/paypal.dart';
import '../../widget/paypal/paypalconfirmation/confirmationamount.dart';
import '../../widget/paypal/paypalconfirmation/confirmationbutton.dart';
import '../../widget/paypal/paypalconfirmation/confirmationheader.dart';
import '../../widget/paypal/paypalconfirmation/confirmationicon.dart';
import '../../widget/paypal/paypalpaiment/paypal2.dart' as payment_service;


class PaymentConfirmationScreen extends StatelessWidget {
  final String paymentMethod;
  final PaymentData paymentData;
  final payment_service.PaymentService paymentService;
  final double amount;

  const PaymentConfirmationScreen({
    super.key,
    required this.paymentMethod,
    required this.paymentData,
    required this.paymentService,
    this.amount = 35.99, // Default for testing
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentConfirmationController(
      paymentMethod: paymentMethod,
      paymentData: paymentData,
      paymentService: paymentService,
      amount: amount,
    ));

    return Scaffold(
      backgroundColor: paymentMethod == 'paypal'
          ? const Color(0xFF0070BA)
          : const Color(0xFF007BFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ConfirmationHeader(),
                const SizedBox(height: 32),
                const ConfirmationIcon(),
                const SizedBox(height: 32),
                Text(
                  'Finalizing payment'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  paymentMethod == 'paypal'
                      ? 'You will be redirected to PayPal to complete your payment securely.'.tr
                      : 'Please wait while we process your payment.'.tr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Confirmationamount(amount: amount),
                const SizedBox(height: 32),
                const ConfirmationButton(),
                const SizedBox(height: 16), // Extra padding at bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}