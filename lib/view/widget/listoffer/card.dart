
import 'package:credit_app/view/widget/listoffer/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:credit_app/core/constant/colors.dart';

import '../../screen/credit/commercant/checkoffre.dart';


class OfferCard extends StatelessWidget {
  final int index;
  final Map<String, dynamic> offer;

  const OfferCard({super.key, required this.index, required this.offer});

  @override
  Widget build(BuildContext context) {
    final status = offer['status'.tr]?.toString().toLowerCase() ?? 'Unknown'.tr;
    final statusColor = getStatusColor(status);
    final statusText = getStatusText(status);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_outlined, color:AppColors.darkBlue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                      "${"credit_offer_number".tr} ${index + 1}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                "${"Status".tr} : $statusText",
                style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Text(
                "${"Creation date".tr}: ${FormatStatusDate(offer['createdAt'])}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.to(() => CheckOffer(offer: offer));
                },
                icon:  Icon(Icons.visibility,color: AppColors.darkBlue,),
                label: Text("See details".tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
