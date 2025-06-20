import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EvaluationCard extends StatelessWidget {
  final Map<String, dynamic> evaluation;

  const EvaluationCard({
    Key? key,
    required this.evaluation,
  }) : super(key: key);

  Color getSatisfactionColor(String status) {
    switch (status) {
      case 'satisfied':
        return const Color(0xFF4CAF50);
      case 'normal':
        return const Color(0xFFFFB300);
      case 'not_satisfied':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(evaluation['createdAt']).toLocal();
    final formattedDate = '${createdAt.day}/${createdAt.month}/${createdAt
        .year}';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            buildRatingRow(
                'Communication'.tr, evaluation['creditCommunicationStars']),
            const SizedBox(height: 8),
            buildRatingRow('Punctuality'.tr, evaluation['paymentTimelinessStars']),
            const SizedBox(height: 8),
            buildRatingRow('Professionalism'.tr,
                evaluation['transactionProfessionalismStars']),
            const SizedBox(height: 12),
            buildSatisfactionStatus(evaluation['satisfactionStatus']),
          ],
        ),
      ),
    );
  }

  Widget buildRatingRow(String label, int stars) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < stars ? Icons.star_rounded : Icons.star_border_rounded,
              color: const Color(0xFFFFB300),
              size: 20,
            );
          }),
        ),
      ],
    );
  }

  Widget buildSatisfactionStatus(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: getSatisfactionColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black12,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status == 'satisfied' ? Icons.sentiment_satisfied_alt_rounded :
            status == 'normal' ? Icons.sentiment_neutral_rounded :
            Icons.sentiment_dissatisfied_rounded,
            color: getSatisfactionColor(status),
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            status == 'satisfied' ? 'Satisfied'.tr :
            status == 'normal' ? 'Normal'.tr : 'Dissatisfied'.tr,
            style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: getSatisfactionColor(status),
            ),
          ),
        ],
      ),
    );
  }
}