import 'package:credit_app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/payment/pay_controller.dart';

class StepNavigation extends StatelessWidget {
  final ClientPaymentControllerImp controller;

  StepNavigation({super.key, required this.controller});

  final List<String> stepLabels =  ['Card'.tr, 'Receipt'.tr, 'Date/Hour'.tr];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 45,
              right: 45,
              top: 16,
              child: Container(
                height: 0.8,
                color: Colors.grey.shade400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(stepLabels.length, (index) {
                final isCompleted = controller.currentStep.value > index;
                final isCurrent = controller.currentStep.value == index;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCompleted || isCurrent
                            ? AppColors.blue900
                            : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stepLabels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isCompleted || isCurrent
                            ? AppColors.blue900
                            : Colors.grey,
                        fontWeight: isCurrent
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
