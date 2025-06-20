import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyInput extends StatelessWidget {
  final String? initialValue;
  final String selectedCurrency;
  final ValueChanged<String>? onAmountChanged;
  final ValueChanged<String>? onCurrencyChanged;
  final String? Function(String?) valid;
  final TextEditingController? mycontroller;

  const CurrencyInput({
    super.key,
    this.initialValue,
    required this.selectedCurrency,
    this.onAmountChanged,
    this.onCurrencyChanged,
    required this.valid,
    required this.mycontroller
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: mycontroller,
            validator: valid,
            initialValue: initialValue,
            onChanged: onAmountChanged,
            decoration: InputDecoration(
              hintText: "Amount".tr,hintStyle: TextStyle(color: Colors.grey),
              prefixIcon:Icon(Icons.attach_money),
              contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCurrency,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                items: [
                  DropdownMenuItem(value: 'TND', child: Text('TND'.tr)),
                  DropdownMenuItem(value: 'USD', child: Text('USD'.tr)),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR'.tr)),
                ],
                onChanged: (value) {
                  if (value != null && onCurrencyChanged != null) {
                    onCurrencyChanged!(value);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
