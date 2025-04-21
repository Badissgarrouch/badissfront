import 'package:credit_app/view/widget/invitation/respond/detail_row.dart';
import 'package:flutter/material.dart';


class RespondDetailsCard extends StatelessWidget {
  const RespondDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
          const DetailRow(
            icon: Icons.email,
            title: "Email",
            value: "ahmed.client@email.com",
          ),
          const Divider(height: 32),
          const DetailRow(
            icon: Icons.phone,
            title: "Téléphone",
            value: "+216 50 123 456",
          ),
          const Divider(height: 32),
          const DetailRow(
            icon: Icons.calendar_today,
            title: "Date d'invitation",
            value: "15 Mars 2023",
          ),
        ],
      ),
    );
  }
}