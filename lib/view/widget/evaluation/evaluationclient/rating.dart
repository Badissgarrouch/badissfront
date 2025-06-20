import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingSummaryChart extends StatelessWidget {
  final List<Map<String, dynamic>> evaluations;

  const RatingSummaryChart({super.key, required this.evaluations});

  @override
  Widget build(BuildContext context) {
    final commAvg = _calculateAverage('creditCommunicationStars');
    final timeAvg = _calculateAverage('paymentTimelinessStars');
    final profAvg = _calculateAverage('transactionProfessionalismStars');
    final overallAvg = (commAvg + timeAvg + profAvg) / 3;

    return Column(
      children: [
        Text(
          'Summary of Evaluations'.tr,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF263238),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Text(
              'Overall Average'.tr,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 70,
              height: 70,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: overallAvg / 5,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade200,
                    color: const Color(0xFF0288D1),
                  ),
                  Text(
                    overallAvg.toStringAsFixed(1),
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0288D1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),


        buildRatingDetail('Communication'.tr, commAvg),
        const SizedBox(height: 12),
        buildRatingDetail('Punctuality'.tr, timeAvg),
        const SizedBox(height: 12),
        buildRatingDetail('Professionalism'.tr, profAvg),
      ],
    );
  }

  Widget buildRatingDetail(String label, double value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < value.round()
                    ? Icons.star_rounded
                    : Icons.star_border_rounded,
                color: const Color(0xFFFFB300),
                size: 20,
              );
            }),
          ),
        ),
        Text(
          value.toStringAsFixed(1),
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0288D1),
          ),
        ),
      ],
    );
  }

  double _calculateAverage(String field) {
    if (evaluations.isEmpty) return 0;
    final sum = evaluations.fold(0.0, (sum, eval) => sum + eval[field]);
    return sum / evaluations.length;
  }
}