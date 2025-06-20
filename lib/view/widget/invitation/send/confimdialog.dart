import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSendConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Confirm sending".tr),
      content: Text("Would you like to send an invitation to this merchant?".tr),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel".tr),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child:  Text("Confirm".tr),
        ),
      ],
    ),
  );
}

void showDeleteConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Delete invitation".tr),
      content: Text("Do you want to delete the invitation sent to this merchant?".tr),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel".tr),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child:Text("Delete".tr),
        ),
      ],
    ),
  );
}