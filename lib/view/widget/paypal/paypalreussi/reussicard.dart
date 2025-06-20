import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/paypal/paypalreussi_controller.dart';


class ReussiCard extends StatelessWidget {
  final String transactionId;
  final String paymentMethod;
  final double amount;

  const ReussiCard({
    super.key,
    required this.transactionId,
    required this.paymentMethod,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentSuccessController>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Order number'.tr, transactionId),
          const SizedBox(height: 16),
          _buildDetailRow('Amount paid'.tr, '${amount.toStringAsFixed(2)} €'),
          const SizedBox(height: 16),
          _buildDetailRow('Payment method'.tr, paymentMethod == 'paypal' ? 'PayPal' : 'Bank card'),
          const SizedBox(height: 16),
          _buildDetailRow('Date'.tr, controller.formatDateTime(DateTime.now())),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}