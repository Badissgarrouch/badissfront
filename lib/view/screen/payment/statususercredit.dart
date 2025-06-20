import 'package:credit_app/core/constant/colors.dart';
import 'package:credit_app/data/model/usermodel.dart';

import 'package:flutter/material.dart';

import '../../widget/payment/statususercredit/maonthcard.dart';
import '../../widget/payment/statususercredit/status2.dart';

class Test2 extends StatelessWidget {
  final User user;

  const Test2({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${user.nom} ${user.prenom}',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.blue800,
                AppColors.blue700,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 26),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PaymentStatusCard(user: user),
            const SizedBox(height: 16),
            ...user.mois.map((mois) => MonthCard(mois: mois)).toList(),
          ],
        ),
      ),
    );
  }
}