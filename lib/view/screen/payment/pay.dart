import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/payment/pay_controller.dart';
import '../../../core/constant/colors.dart';
import '../../widget/payment/pay/datetime.dart';
import '../../widget/payment/pay/navigation.dart';
import '../../widget/payment/pay/recu.dart';
import '../../widget/payment/pay/selectionstep.dart';

class ClientPaymentScreen extends StatelessWidget {
  ClientPaymentScreen({super.key});

  final controller = Get.put( ClientPaymentControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pay Information'.tr,

            style: TextStyle(fontWeight: FontWeight.bold,
            color: AppColors.blue900)),

        centerTitle: true,
        elevation: 0,

        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          StepNavigation(controller: controller),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                switch (controller.currentStep.value) {
                  case 0: return CardSelectionStep(controller: controller);
                  case 1: return ReceiptStep(controller: controller);
                  case 2: return DateTimeStep(controller: controller);
                  default: return CardSelectionStep(controller: controller);
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}