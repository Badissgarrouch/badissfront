import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../conroller/notification/notification_controller.dart';
import '../../view/widget/notification/noti_type.dart';

class FilterDialogActions extends StatelessWidget {
  final NotificationController controller;
  final Rx<Map<NotificationType, bool>> localFilterStates;
  final RxBool localSelectAll;

  const FilterDialogActions({
    super.key,
    required this.controller,
    required this.localFilterStates,
    required this.localSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildActionButton(
          text: 'Close'.tr,
          color: Colors.red[600]!, // Pass the specific shade
          onPressed: Get.back,
        ),
        buildActionButton(
          text: 'Apply'.tr,
          color: Colors.green[600]!, // Pass the specific shade
          onPressed: () {
            controller.updateFilterStates(
              localFilterStates.value,
              localSelectAll.value,
            );
            Get.back();
          },
        ),
      ],
    );
  }

  Widget buildActionButton({
    required String text,
    required Color color, // Keep as Color
    required VoidCallback onPressed,
  }) {
    return Flexible(
      fit: FlexFit.tight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: Colors.white,
          foregroundColor: color, // Use the passed color directly
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: color, width: 1),
          ),
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}