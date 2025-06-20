import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/paypal/paypalreussi_controller.dart';

class ReussiIcon extends StatelessWidget {
  const ReussiIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentSuccessController>();

    return AnimatedBuilder(
      animation: controller.checkAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.scaleAnimation.value,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: const Color(0xFF28A745),
                size: 60 * controller.checkAnimation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}