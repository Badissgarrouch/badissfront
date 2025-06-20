import 'package:credit_app/core/constant/colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.blue100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_outline,
        color: AppColors.blue600,
        size: 24,
      ),
    );
  }
}