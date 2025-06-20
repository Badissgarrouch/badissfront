import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/payment/pay_controller.dart';

class CardDetails extends StatelessWidget {
  final ClientPaymentControllerImp controller;

  const CardDetails({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow('Type:'.tr, controller.selectedCard.value!['cardType'] ?? ''),
          DetailRow('Full number:'.tr, controller.selectedCard.value!['cardNumber'] ?? ''),
        ],
      ),
    );
  }

  Widget DetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
