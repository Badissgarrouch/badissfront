import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue[600],
        checkColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        checkboxShape: const CircleBorder(),
        side: const BorderSide(
          color: Colors.black54,
          width:1.5,
        ),
      ),
    );
  }
}