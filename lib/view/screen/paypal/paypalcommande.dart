import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../conroller/paypal/paypalcommande_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String transactionId;
  final String paymentMethod;
  final double amount;

  const OrderDetailsScreen({
    super.key,
    required this.transactionId,
    required this.paymentMethod,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Summary'.tr,
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Lottie.asset(
              'assets/lotties/paypal.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            buildInfoCard(context),
            const SizedBox(height: 24),
            buildBackButton(),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoItem('Order number'.tr, transactionId),
          const SizedBox(height: 12),
          buildInfoItem('Amount paid'.tr, '${amount.toStringAsFixed(2)} €'),
          const SizedBox(height: 12),
          buildInfoItem('Méthode de paiement'.tr,
              paymentMethod == 'paypal'.tr ? 'PayPal'.tr : 'Bank card'.tr),
          const SizedBox(height: 12),
          buildInfoItem('Date'.tr,
              OrderDetailsController().formatDate(DateTime.now())),
          const SizedBox(height: 12),
          buildInfoItem('Status'.tr, 'Confirmed'.tr),
        ],
      ),
    );
  }

  Widget buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget buildBackButton() {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () => Get.offAllNamed('/home'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child:Text(
          'Back'.tr,
          style: TextStyle(fontSize: 14,color: Colors.white),
        ),
      ),
    );
  }
}