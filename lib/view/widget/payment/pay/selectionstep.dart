import 'package:credit_app/view/widget/payment/pay/button.dart';
import 'package:credit_app/view/widget/payment/pay/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../conroller/payment/pay_controller.dart';


class CardSelectionStep extends StatelessWidget {
  final ClientPaymentControllerImp controller;

  const CardSelectionStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Pay your credit on the cards available from your merchant".tr,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 30),
        Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'See available Cards',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Obx(() {
                  return PopupMenuButton<String>(
                    onSelected: (value) {
                      final index = int.parse(value);
                      controller.selectedCard.value = controller.availableCards[index];
                    },
                    itemBuilder: (BuildContext context) {
                      return controller.availableCards.asMap().entries.map((entry) {
                        return PopupMenuItem(
                          value: entry.key.toString(),
                          child: Text(entry.value['cardType'] ?? 'Unnamed card'.tr),
                        );
                      }).toList();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedCard.value != null
                                ? controller.selectedCard.value!['cardType'] ?? 'Unknown card type'.tr
                                : 'Select a card'.tr,
                            style: TextStyle(
                              color: controller.selectedCard.value != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  );
                }),
                Obx(() {
                  if (controller.selectedCard.value != null) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        CardDetails(controller: controller),
                      ],
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        NavigationButtons(controller: controller, currentStep: 0),
      ],
    );
  }
}