import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../conroller/paypal/paypalreussi_controller.dart';
import '../../widget/paypal/paypalreussi/reussibutton.dart';
import '../../widget/paypal/paypalreussi/reussicard.dart';
import '../../widget/paypal/paypalreussi/reussiicon.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String transactionId;
  final String paymentMethod;
  final double amount;

  const PaymentSuccessScreen({
    super.key,
    required this.transactionId,
    required this.paymentMethod,
    this.amount = 35.99,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentSuccessController(
      transactionId: transactionId,
      paymentMethod: paymentMethod,
      amount: amount,
    ));

    return Scaffold(
      backgroundColor: const Color(0xFF28A745),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const ReussiIcon(),
                const SizedBox(height: 32),
                Text(
                  'Payment successful!'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your order has been successfully processed.\n You will receive a confirmation email shortly.'.tr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ReussiCard(
                  transactionId: transactionId,
                  paymentMethod: paymentMethod,
                  amount: amount,
                ),
                const SizedBox(height: 32),
                const ReussiButtons(),
                const SizedBox(height: 16), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}