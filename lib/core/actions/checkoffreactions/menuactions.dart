import 'package:credit_app/core/actions/checkoffreactions/buttonactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../conroller/credit/commercant/checkoffre_controller.dart';

void showOfferActionMenu(BuildContext context, String offerId) {
  CheckOfferControllerImp controller =Get.put(CheckOfferControllerImp());
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title:  Text("Accept offer".tr),
              onTap: () {
              controller.respondToOffer(
              offerId: offerId, action: 'accept',
              );}
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title:  Text("Decline offer".tr),
              onTap: () {
                controller.respondToOffer(
                  offerId: offerId,
                  action: 'reject',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.orange),
              title:  Text("Request changes".tr),
              onTap: (){ showModificationDialog(context, controller, offerId);

              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}