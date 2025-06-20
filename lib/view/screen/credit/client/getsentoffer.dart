import 'package:credit_app/conroller/credit/commercant/checkoffre_controller.dart';
import 'package:credit_app/view/widget/listoffer/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../conroller/credit/client/getsentoffer_controller.dart';

import '../../../../core/constant/colors.dart';
import '../../../widget/invitation/checkoffre/actuelstatus.dart';
import '../../../widget/invitation/checkoffre/appbar.dart';
import '../../../widget/invitation/checkoffre/information/infocard.dart';
import '../../../widget/invitation/checkoffre/information/infoitem.dart';
import '../../../widget/invitation/sendoffer/header.dart';


class Getsentoffer extends StatelessWidget {
  final dynamic offer;
  const Getsentoffer({super.key,required this.offer,});

  @override
  Widget build(BuildContext context) {
    Get.put(GetSentOfferControllerImp());
    return Scaffold(
      appBar: CustomAppBar(
        title: "Offer details".tr,

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusHeader(
              status: offer['status'.tr] ?? "Status Unknown".tr,
              date: FormatStatusDate(offer['createdAt']),
            ),
            const SizedBox(height: 28),

             SectionHeader(
              icon: Icons.person_outline,
              title: "Merchant Information".tr,
            ),
            InfoCard(
              children:  [
                InfoCard(
                  children: [
                    InfoItem(
                        label: "Full name".tr,
                        value: offer['recipientName']
                    ),
                    InfoItem(
                      label: "Email".tr,
                      value:  offer['recipientEmail'],
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            SectionHeader(
              icon: Icons.attach_money_outlined,
              title: "Financial details".tr,
            ),
            InfoCard(
              children: [
                InfoItem(label: "Amount requested".tr,value: "${offer['totalCredit']}${offer['devise']}"),
                InfoItem(label: "Duration".tr, value: "${offer['duration']} mois"),
                InfoItem(label: "First payment".tr, value:formatDate(offer['startDate'])),
                InfoItem(label: "Monthly salary".tr, value: "${offer['monthlySalary']}${offer['devise']}"),
                InfoItem(label: "Percentage of salary".tr, value: "${offer['salaryPercentage']} %"),
                InfoItem(
                  label: "Purpose of the credit".tr,
                  value:  offer['purpose'] ?? 'Not specified'.tr,
                  maxLines: 2,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SectionHeader(
              icon: Icons.comment_outlined,
              title: "My comment".tr,
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  offer['comment']??"No comment".tr,
                  style: TextStyle(color: AppColors.textDark, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 24),

            SectionHeader(
              icon: Icons.calendar_today_outlined,
              title: "Status & History".tr,
            ),
            InfoCard(
              children:  [
                InfoItem(label: "Request date".tr, value: FormatStatusDate(offer['createdAt'])),
                InfoItem(label: "Status".tr, value: offer['status'] ?? "Status Unknown".tr,maxLines: 2,),
                InfoItem(
                  label: "Last update".tr,
                  value: FormatStatusDate(offer['respondedAt']?? "Not modified".tr),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}

String formatDate(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    return "${date.day}/${date.month}/${date.year}";
  } catch (e) {
    return dateString;
  }
}