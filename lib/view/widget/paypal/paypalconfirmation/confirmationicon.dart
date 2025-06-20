import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/paypal/paypalconfirmation_controller.dart';


class ConfirmationIcon extends StatelessWidget {
  const ConfirmationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentConfirmationController>();

    return AnimatedBuilder(
      animation: controller.scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.scaleAnimation.value,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: controller.paymentMethod == 'paypal'
                  ? Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child:Center(
                  child: Text(
                    'PayPal'.tr,
                    style: TextStyle(
                      color: Color(0xFF0070BA),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
                  : const Icon(
                Icons.credit_card,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        );
      },
    );
  }
}