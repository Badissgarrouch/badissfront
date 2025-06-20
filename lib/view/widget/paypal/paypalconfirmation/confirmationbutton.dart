import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/paypal/paypalconfirmation_controller.dart';


class ConfirmationButton extends StatelessWidget {
  const ConfirmationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentConfirmationController>();

    return Obx(() => SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.isProcessing.value ? null : controller.processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: controller.paymentMethod == 'paypal'
              ? const Color(0xFF0070BA)
              : const Color(0xFF007BFF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: controller.isProcessing.value
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  controller.paymentMethod == 'paypal'
                      ? const Color(0xFF0070BA)
                      : const Color(0xFF007BFF),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Processing in progress...'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
            : Text(
          controller.paymentMethod == 'paypal'
              ? 'Continue with PayPal'.tr
              : 'Confirm payment'.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ));
  }
}