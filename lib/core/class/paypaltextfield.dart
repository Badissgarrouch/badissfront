import 'package:credit_app/core/class/paypalinputdeco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  final IconData icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,

    required this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: FormUtils.buildInputDecoration(
        label: label,

        icon: icon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
      textCapitalization: textCapitalization,
      style: const TextStyle(fontSize:15, color: Colors.black87),
    );
  }
}