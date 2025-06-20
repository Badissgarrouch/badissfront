import 'package:credit_app/core/actions/checkoffreactions/menubuttonactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/credit/commercant/checkoffre_controller.dart';

class OfferActions extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onModify;
  final String offerId;

  const OfferActions({
    super.key,
    required this.onAccept,
    required this.onReject,
    required this.onModify,
    required this.offerId,
  });

  @override
  Widget build(BuildContext context) {
    Get.find<CheckOfferControllerImp>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          offerId: offerId,
          icon: Icons.check_circle,
          label: "Accept".tr,
          color: Colors.green,
          onPressed: onAccept,
        ),
        ActionButton(
          offerId: offerId,
          icon: Icons.delete,
          label: "Refuse".tr,
          color: Colors.red,
          onPressed: onReject,
        ),
        ActionButton(
          offerId: offerId,
          icon: Icons.edit,
          label: "Modify".tr,
          color: Colors.orange,
          onPressed: onModify,
        ),
      ],
    );
  }
}





void showModificationDialog(BuildContext context, CheckOfferControllerImp controller, String offerId) {
  final commentController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:  Text('Change request'.tr),
      content: TextField(
        controller: commentController,
        decoration:  InputDecoration(
          labelText: 'Comment'.tr,
          border: OutlineInputBorder(),
        ),
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () {
          },
          child:  Text('Cancel'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            controller.respondToOffer(
              offerId: offerId,
              action: 'request modification',
              comment: commentController.text,
            );

          },
          child: Text('Send'.tr),
        ),
      ],
    ),
  );
}