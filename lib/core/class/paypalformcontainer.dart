import 'package:flutter/material.dart';

import '../constant/colors.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final IconData? titleIcon;

  const FormContainer({
    super.key,
    required this.children,
    this.title,
    this.titleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (titleIcon != null) ...[
                  Icon(titleIcon, color: Colors.black87, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue400, // AppColors.blue400
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
          ...children,
        ],
      ),
    );
  }
}