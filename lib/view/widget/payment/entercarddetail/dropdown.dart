import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../conroller/payment/enterdetailcard_controller.dart';

import '../../../../core/share/utils.dart';

class Dropdown extends StatelessWidget {
  final CardField field;
  final EnterDetailCardControllerImp controller;

  const Dropdown({
    super.key,
    required this.field,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: field.selectedCardName,
      items: controller.cardNames.map((name) {
        return DropdownMenuItem(
          value: name,
          child: Row(
            children: [
              Image.asset(
                getCardLogo(name),
                width: 30,
                height: 20,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.credit_card),
              ),
              const SizedBox(width: 10),
              Text(name),
            ],
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        field.selectedCardName = newValue!;
        controller.update();
      },
      decoration: InputDecoration(
        labelText: "Card type".tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}