import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EvaluationDialog extends StatelessWidget {
  final int totalStars;
  final double averageStars;

  const EvaluationDialog({
    Key? key,
    required this.totalStars,
    required this.averageStars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF01579B).withOpacity(0.1),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                size: 40,
                color: Color(0xFF01579B),
              ),
            ).animate().scale(duration: 300.ms),
            const SizedBox(height: 12),
            // Title
            Text(
              'Success'.tr,
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF01579B),
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
            const SizedBox(height: 8),
            // Message
            Text(
              "${'Rating submitted!\nTotal'.tr}: $totalStars\n${'stars\nAverage'.tr}: ${averageStars.toStringAsFixed(1)}",

              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
            const SizedBox(height: 16),
            // OK Button
            Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'OK'.tr,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate().slideY(begin: 0.2, end: 0, duration: 300.ms, delay: 300.ms),
          ],
        ),
      ),
    );
  }
}