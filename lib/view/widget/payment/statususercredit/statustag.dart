import 'package:credit_app/data/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusTag extends StatelessWidget {
  final bool isComplete;
  final Mois? mois;

  const StatusTag({Key? key, required this.isComplete, this.mois})
      : super(key: key);

  factory StatusTag.forMonth({required Mois mois}) {
    return StatusTag(
      isComplete: mois.paye,
      mois: mois,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMonth = mois != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isComplete
            ? const Color(0xFFE8F5E9)
            : isMonth
            ? const Color(0xFFFFF8E1)
            : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isComplete
            ? isMonth ? 'Paid'.tr : 'Complet'.tr
            : isMonth ? 'Pending'.tr : 'In progress'.tr,
        style: textTheme.bodySmall?.copyWith(
          color: isComplete
              ? const Color(0xFF2E7D32)
              : isMonth
              ? const Color(0xFFF57F17)
              : const Color(0xFFD32F2F),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}