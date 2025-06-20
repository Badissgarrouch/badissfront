
import 'package:credit_app/view/widget/invitation/sendoffer/formlabel.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool requiredField;
  final String hintText;
  final TextEditingController? mycontroller;
  final IconData? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?) valid;

  const CustomTextField({
    super.key,
    required this.label,
    this.requiredField = false,
    required this.hintText,
    this.prefixIcon,
    this.maxLines = 1,
    this.keyboardType,
    required this.valid,
    required this.mycontroller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(text: label, requiredField: requiredField),
        const SizedBox(height: 8),
        TextFormField(
          controller: mycontroller,
          validator: valid,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey,fontSize: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}