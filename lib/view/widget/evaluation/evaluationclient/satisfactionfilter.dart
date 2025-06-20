import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../conroller/evaluation/clientevaluation_controller.dart';

class SatisfactionFilter extends StatelessWidget {
  final ReceivedEvaluationsController controller;

  const SatisfactionFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedFilter.value,
          items: [
            DropdownMenuItem(
              value: 'all',
              child: Text('All reviews'.tr,
                  style: GoogleFonts.roboto()),
            ),
            DropdownMenuItem(
              value: 'satisfied',
              child: Row(
                children: [
                  const Icon(Icons.sentiment_satisfied_alt,
                      color: Colors.green),
                  const SizedBox(width: 8),
                  Text('Satisfied'.tr),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'normal',
              child: Row(
                children: [
                  const Icon(Icons.sentiment_neutral,
                      color: Colors.orange),
                  const SizedBox(width: 8),
                  Text('Normal'.tr),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'not_satisfied',
              child: Row(
                children: [
                  const Icon(Icons.sentiment_dissatisfied,
                      color: Colors.red),
                  const SizedBox(width: 8),
                  Text('Dissatisfied'.tr),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              controller.filterEvaluations(value);
            }
          },
          isExpanded: true,
          style: GoogleFonts.roboto(
            color: const Color(0xFF263238),
          ),
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ),
    );
  }
}