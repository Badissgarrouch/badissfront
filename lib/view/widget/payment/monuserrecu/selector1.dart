import 'package:credit_app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const TypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color:Colors.black12),
        ),
        child: Row(
          children: [
            buildChoiceChip('Customer'.tr, 'client', context),
            buildChoiceChip('Trader'.tr, 'commercant', context),
          ],
        ),
      ),
    );
  }

  Widget buildChoiceChip(String label, String type, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: ChoiceChip(
        label: Center(child: Text(label)),
        selected: selectedType == type,
        onSelected: (_) => onTypeChanged(type),
        selectedColor: AppColors.blue700,
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: selectedType == type ? Colors.white : AppColors.blue700,
        ),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}