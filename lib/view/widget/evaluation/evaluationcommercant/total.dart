import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalStars extends StatelessWidget {
  final int totalStars;
  final double averageStars;

  const TotalStars({
    Key? key,
    required this.totalStars,
    required this.averageStars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.blue[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.star_rounded, color: Colors.amber[600], size: 24),
              const SizedBox(width: 8),
              Text(
                '$totalStars',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF01579B),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star_half_rounded, color: Colors.amber[600], size: 24),
              const SizedBox(width: 8),
              Text(
                '${averageStars.toStringAsFixed(1)}',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF01579B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}