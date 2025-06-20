import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;


  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 24, color:Colors.lightBlue),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color:Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}