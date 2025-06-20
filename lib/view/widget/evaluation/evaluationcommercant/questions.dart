import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'emojie.dart';

class Question extends StatelessWidget {
  final Map<String, String> question;
  final String emoji;
  final int stars;
  final Function(String) onEmojiChanged;
  final Function(int) onStarsChanged;

  const Question({
    Key? key,
    required this.question,
    required this.emoji,
    required this.stars,
    required this.onEmojiChanged,
    required this.onStarsChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[100]!,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question['text']!,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF01579B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                question['description']!,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Emoji(
                      emoji: '😊',
                      color: Colors.teal,
                      label: 'Pos'.tr,
                      isSelected: emoji == '😊',
                      onTap: () => onEmojiChanged('😊'),
                    ),
                  ),
                  Flexible(
                    child: Emoji(
                      emoji: '🙂',
                      color: Colors.blue,
                      label: 'Neu'.tr,
                      isSelected: emoji == '🙂',
                      onTap: () => onEmojiChanged('🙂'),
                    ),
                  ),
                  Flexible(
                    child: Emoji(
                      emoji: '😞',
                      color: Colors.redAccent,
                      label: 'Neg'.tr,
                      isSelected: emoji == '😞',
                      onTap: () => onEmojiChanged('😞'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Detailed Rating'.tr,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF01579B),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < stars ? Icons.star_rounded : Icons.star_border_rounded,
                      color: Colors.amber[600],
                      size: 34,
                    ),
                    onPressed: () => onStarsChanged(index + 1),
                  );
                }).animate().scale(delay: 200.ms),
              ),
            ],
          ),
        ),
      ),
    ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms);
  }
}