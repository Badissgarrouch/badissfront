import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/paypal/paypal_controller.dart';
import '../../../../core/class/paypalformcontainer.dart';
import '../../../../core/class/paypaltextfield.dart';
import '../../../../data/model/paypal.dart';

class PayPalForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PaymentData paymentData;

  const PayPalForm({
    super.key,
    required this.formKey,
    required this.paymentData,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();
    final obscurePassword = true.obs;

    return FormContainer(
      title: 'PayPal connexion ',
      titleIcon: Icons.account_balance_wallet,
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.emailController,
                label: 'Email PayPal',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your PayPal email'.tr;
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Invalid email'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                controller: controller.paypalPasswordController ?? TextEditingController(),
                label: 'PayPal password'.tr,
                icon: Icons.lock,
                obscureText: obscurePassword.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black87,
                    size: 20,
                  ),
                  onPressed: () => obscurePassword.toggle(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password'.tr;
                  }
                  return null;
                },
              )),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.black87, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your PayPal credentials are secure and encrypted'.tr,
                      style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}