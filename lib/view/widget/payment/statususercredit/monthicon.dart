import 'package:credit_app/data/model/usermodel.dart';
import 'package:flutter/material.dart';


class MonthIcon extends StatelessWidget {
  final Mois mois;

  const MonthIcon({Key? key, required this.mois}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: mois.paye
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFFFF8E1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        mois.paye ? Icons.check : Icons.access_time,
        color: mois.paye
            ? const Color(0xFF2E7D32)
            : const Color(0xFFF57F17),
      ),
    );
  }
}