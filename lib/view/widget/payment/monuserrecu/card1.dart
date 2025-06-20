import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/view/widget/payment/monuserrecu/avatar1.dart';
import 'package:credit_app/view/widget/payment/monuserrecu/info1.dart';
import 'package:credit_app/data/model/usermodel.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.blue600, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const UserAvatar(),
              const SizedBox(width: 16),
              UserInfo(user: user),
              Icon(
                Icons.chevron_right,
                color: AppColors.blue600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}