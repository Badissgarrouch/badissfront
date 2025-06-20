import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/view/widget/payment/statususercredit/statitem.dart';
import 'package:credit_app/view/widget/payment/statususercredit/statustag.dart';
import 'package:credit_app/data/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentStatusCard extends StatelessWidget {
  final User user;

  const PaymentStatusCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final total = int.parse(user.duration);
    final payees = user.mois.where((m) => m.paye).length;
    final restantes = total - payees;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.blue700, size: 22),
                const SizedBox(width: 12),
                Text(
                  'Monthly payments'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatItem(
                  label: 'Total'.tr,
                  value: '$total',
                  color: const Color(0xFFF57F17),
                ),
                StatItem(
                  label: 'Paid'.tr,
                  value: '$payees',
                  color: const Color(0xFF2E7D32),
                ),
                StatItem(
                  label: 'Remaining'.tr,
                  value: '$restantes',
                  color: const Color(0xFFD32F2F),
                ),
                StatusTag(isComplete: payees == total),
              ],
            ),
          ],
        ),
      ),
    );
  }
}