import 'package:credit_app/core/constant/routes.dart';
import 'package:credit_app/data/model/usermodel.dart';
import 'package:credit_app/view/widget/payment/statususercredit/monthicon.dart';
import 'package:credit_app/view/widget/payment/statususercredit/statustag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthCard extends StatelessWidget {
  final Mois mois;

  const MonthCard({Key? key, required this.mois}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: mois.paye && mois.paymentDetail != null
          ? () {
        Get.toNamed(
          AppRoute.recevoirPayment,
          arguments: {'mois': mois},
        );
      }
          : null,
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(bottom: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              MonthIcon(mois: mois),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'Monthly payment'.tr} ${mois.numero}",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      mois.paye ? 'Payment completed'.tr : 'Payment pending'.tr,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              StatusTag.forMonth(mois: mois),
            ],
          ),
        ),
      ),
    );
  }
}