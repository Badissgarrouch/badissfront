import 'package:credit_app/view/widget/payment/pay/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../conroller/payment/pay_controller.dart';

class DateTimeStep extends StatelessWidget {
  final ClientPaymentControllerImp controller;

  const DateTimeStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Select your payment date".tr,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        SizedBox(height: 20),
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
                  'Date and time of payment'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.calendar_today, color: Colors.black87, size: 19),
                          label: Text("Choose a date".tr, style: TextStyle(color: Colors.black87, fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => controller.pickDate(Get.context!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50, // Hauteur fixe agrandie
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.access_time, color: Colors.black87, size: 19),
                          label: Text('Choose an hour'.tr, style: TextStyle(color: Colors.black87, fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => controller.pickTime(Get.context!),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => Text(
                        controller.selectedDate.value != null
                            ? "${'Date'.tr}: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value!)}" // Format corrigé
                            : 'No date selected'.tr,
                        style: const TextStyle(fontSize: 14),
                      )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => Text(
                        controller.selectedTime.value != null
                            ? "${"Hour:".tr} ${controller.selectedTime.value!.format(Get.context!)}"
                            : 'No hour selected'.tr,
                        style: const TextStyle(fontSize: 14),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        NavigationButtons(controller: controller, currentStep: 2),
      ],
    );
  }
}