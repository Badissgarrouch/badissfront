import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart';

class PaymentMethodsCard extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodChanged;

  const PaymentMethodsCard({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment method'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.blue400,
            ),
          ),
          const SizedBox(height: 12),
          buildPaymentOption('card', Icons.credit_card, 'Bank card'.tr, const Color(0xFF005EA6)),
          const SizedBox(height: 8),
          buildPaymentOption('paypal', Icons.account_balance_wallet, 'PayPal'.tr, const Color(0xFF003087)),
        ],
      ),
    );
  }

  Widget buildPaymentOption(String value, IconData icon, String title, Color iconColor) {
    bool isSelected = selectedMethod == value;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? iconColor : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blueGrey[50]!.withOpacity(0.3) : Colors.white,
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: selectedMethod,
        onChanged: (String? newValue) {
          if (newValue != null) {
            onMethodChanged(newValue);
          }
        },
        title: Row(
          children: [
            Icon(icon, color: Colors.black87, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        activeColor: iconColor,
      ),
    );
  }
}