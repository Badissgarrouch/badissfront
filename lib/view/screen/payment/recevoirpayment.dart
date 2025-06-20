import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/data/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/payment/recevoirpayment/paymentcard.dart';
import '../../widget/payment/recevoirpayment/row.dart';

class Recevoirpayment extends StatelessWidget {
  const Recevoirpayment({super.key});

  @override
  Widget build(BuildContext context) {
    final Mois mois = Get.arguments['mois'] as Mois;
    final PaymentDetail? paymentDetail = mois.paymentDetail;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Payment receipt'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PaymentCard(
              title: 'Sent to:'.tr,
              children: [
                TheRow(label: 'Card type:'.tr, value: paymentDetail?.cardType ?? ''),
                TheRow(label: 'Card number:'.tr, value: paymentDetail?.cardNumber ?? '•••• •••• •••• ••••'),
              ],
            ),
            const SizedBox(height: 15),
            PaymentCard(
              title: 'Receipt photo'.tr,
              children: [
                Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    image: paymentDetail?.receiptImageUrl.isNotEmpty == true
                        ? DecorationImage(
                      image: NetworkImage('${paymentDetail!.receiptImageUrl}'),
                      fit: BoxFit.cover,
                    )
                        : const DecorationImage(
                      image: AssetImage('assets/receipt_sample.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  paymentDetail?.receiptImageUrl.isNotEmpty == true
                      ? 'Receipt sent by the customer'.tr
                      : 'No receipt available'.tr,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            PaymentCard(
              title: 'Paid on:'.tr,
              children: [
                TheRow(label: 'Date:'.tr, value: paymentDetail?.paymentDate ??''),
                TheRow(label: 'Heure:'.tr, value: paymentDetail?.paymentTime ?? ''),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
                label: Text(
                  'Back'.tr,
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}