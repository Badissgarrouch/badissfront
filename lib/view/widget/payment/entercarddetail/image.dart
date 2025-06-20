import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardImageBanner extends StatelessWidget {
  const CardImageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/visaa.PNG',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Choose which cards you want customers to pay with".tr,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}