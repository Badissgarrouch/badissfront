import 'package:credit_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../conroller/payment/pay_controller.dart';
import '../../../../core/constant/colors.dart';

class NavigationButtons extends StatelessWidget {
  final ClientPaymentControllerImp controller;
  final int currentStep;

  const NavigationButtons({
    super.key,
    required this.controller,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.goToStep(currentStep - 1),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
                child: Text('Previous'.tr, style: TextStyle(color: Colors.black87, fontSize: 16)),
              ),
            ),
          if (currentStep > 0) const SizedBox(width: 10),

          if (currentStep == 0) ...[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.checkoutscreen);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Pay'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],

          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                if (currentStep < 2) {
                  if (currentStep == 1 && controller.receiptImage.value == null) {
                    Get.snackbar('Error'.tr, 'Please select a receipt'.tr);
                    return;
                  }
                  controller.goToStep(currentStep + 1);
                } else {
                  await controller.submitPayment();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: AppColors.blue900,
              ),
              child: Text(
                currentStep < 2 ? 'Next'.tr : 'Finish'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      );
    });
  }
}