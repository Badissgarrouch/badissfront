import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/paypal/paypalconfirmation_controller.dart';


class ConfirmationHeader extends StatelessWidget {
  const ConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentConfirmationController>();

    return Row(
      children: [
        Obx(() => IconButton(
          onPressed: controller.isProcessing.value ? null : () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
        )),
        Expanded(
          child: Text(
            'Payment confirmation'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}