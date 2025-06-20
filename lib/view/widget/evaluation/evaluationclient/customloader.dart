import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF0288D1),
              strokeWidth: 3,
            ),
            Icon(Icons.star_rounded, color: const Color(0xFFFFB300), size: 20)
                .animate()
                .rotate(duration: const Duration(seconds: 2), curve: Curves.linear),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Loading...'.tr,
          style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}