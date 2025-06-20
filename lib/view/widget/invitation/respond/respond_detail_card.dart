import 'package:credit_app/view/widget/invitation/respond/detail_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RespondDetailsCard extends StatelessWidget {
  final String email;
  final String phone;
  final String date;
  const RespondDetailsCard({super.key,
    required this.email,
    required this.phone,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF5FAFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          DetailRow(
            icon: Icons.email,
            title: "Email".tr,
            value: email,
          ),
          const Divider(height: 32),
           DetailRow(
            icon: Icons.phone,
            title: "Phone".tr,
            value: phone,
          ),
          const Divider(height: 32),
           DetailRow(
            icon: Icons.calendar_today,
            title: "Invitation date".tr,
            value: date,
          ),
        ],
      ),
    );
  }
}