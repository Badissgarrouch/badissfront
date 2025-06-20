import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/view/widget/payment/pay/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../conroller/payment/pay_controller.dart';


class ReceiptStep extends StatelessWidget {
  final ClientPaymentControllerImp controller;

  const ReceiptStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Send your payment receipt".tr,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.grey[200],
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment receipt'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Obx(() {
                  return Container(
                    height: 600,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.receiptImage.value != null
                            ? Colors.transparent
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: controller.receiptImage.value != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        controller.receiptImage.value!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 50, color: Colors.red),
                              SizedBox(height: 10),
                              Text(
                                'Error loading image'.tr,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                        :  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          'No receipt selected'.tr,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.photo_library, color: AppColors.blue900),
                        label: Text(
                          'Gallery'.tr,
                          style: TextStyle(color: Colors.black87),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => controller.pickImage(ImageSource.gallery),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.camera_alt, color: AppColors.blue900),
                        label: Text(
                          'Camera'.tr,
                          style: TextStyle(color: Colors.black87),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => controller.pickImage(ImageSource.camera),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        NavigationButtons(controller: controller, currentStep: 1),
      ],
    );
  }
}