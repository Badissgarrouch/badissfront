import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../conroller/paypal/paypal_controller.dart';
import '../../widget/paypal/paypalpaiment/paypal4.dart';
import '../../widget/paypal/paypalpaiment/paypal5.dart';
import '../../widget/paypal/paypalpaiment/paypal6.dart';
import '../../widget/paypal/paypalpaiment/paypal7.dart';

import '../../widget/paypal/paypalpaiment/paypal9.dart';


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title:  Text(
          'Payment'.tr,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OrderSummaryCard(),
                    const SizedBox(height: 24),
                    Obx(() => PaymentMethodsCard(
                      selectedMethod: controller.selectedPaymentMethod.value,
                      onMethodChanged: controller.changePaymentMethod,
                    )),
                    const SizedBox(height: 24),
                    Obx(() => controller.selectedPaymentMethod.value == 'card'
                        ? CardAndBillingForm(
                      formKey: controller.formKey,
                    )
                        : PayPalForm(
                      formKey: controller.paypalFormKey,
                      paymentData: controller.paymentData.value,
                    )),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => PaymentButton(
            isProcessing: controller.isProcessing.value,
            paymentMethod: controller.selectedPaymentMethod.value,
            onPressed: () => controller.validateAndProceed(context),
          )),
        ],
      ),
    );
  }
}