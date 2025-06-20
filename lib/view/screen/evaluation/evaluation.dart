import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../conroller/evaluation/evaluation_controller.dart';
import '../../widget/evaluation/evaluationcommercant/questions.dart';
import '../../widget/evaluation/evaluationcommercant/submit.dart';
import '../../widget/evaluation/evaluationcommercant/total.dart';
import '../../../core/class/wave.dart';
import '../../../core/constant/routes.dart';

class Evaluation extends StatelessWidget {
  const Evaluation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EvaluationController());
    final controller = Get.find<EvaluationController>();

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[100]!, const Color(0xFFE3F2FD)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 140, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_border_rounded, color: const Color(0xFF01579B), size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'Rate the customer'.tr,
                        style: GoogleFonts.roboto(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF01579B),
                        ),
                      ).animate().slideX(begin: -0.2, end: 0, duration: 600.ms),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Evaluate credit management interactions with this customer.'.tr,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 12),
                  TextField(
                    controller: TextEditingController(text: controller.clientName.value),
                    onChanged: (value) => controller.clientName.value = value,
                    maxLength: 50,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Customer Name'.tr,
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                      prefixIcon: Icon(Icons.person_outline, color: const Color(0xFF01579B), size: 20),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue[100]!, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue[100]!, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF0288D1), width: 1.5),
                      ),
                    ),
                    style: GoogleFonts.roboto(fontSize: 14, color: const Color(0xFF01579B)),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    width: 50,
                    color: const Color(0xFF0288D1),
                  ).animate().scaleX(duration: 600.ms, delay: 400.ms),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (controller.token != null) {
                              Get.toNamed(AppRoute.getclientevalution, arguments: {'token': controller.token});
                            } else {
                              Get.snackbar(
                                'Error'.tr,
                                'Session expired. Please log in again..'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            backgroundColor: const Color(0xFF0288D1).withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rounded, color: const Color(0xFF0288D1), size: 18),
                              const SizedBox(width: 4),
                              Text(
                                'Ratings received'.tr,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0288D1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Check the reviews you received'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                  const SizedBox(height: 12),
                  Obx(
                        () => Column(
                      children: controller.questions
                          .map((question) => Question(
                        question: question,
                        emoji: controller.emojiResponses[question['id']!]!,
                        stars: controller.starResponses[question['id']!]!,
                        onEmojiChanged: (emoji) => controller.changeEmoji(question['id']!, emoji),
                        onStarsChanged: (stars) => controller.changeStars(question['id']!, stars),
                      ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Custom Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assessment_rounded, color: Colors.white, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          'Credit Evaluation'.tr,
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 500.ms),
                  ),
                ),
              ),
            ),
          ),
          // Sticky Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.9), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  Obx(
                        () => TotalStars(
                      totalStars: controller.totalStars,
                      averageStars: controller.averageStars,
                    ).animate().slideY(begin: 0.5, end: 0, duration: 600.ms),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Get.offNamed(AppRoute.homeScreenCommercant),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          backgroundColor: Colors.redAccent.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.exit_to_app, color: Colors.redAccent, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              'Go out'.tr,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                      Obx(
                            () => SubmitButton(
                          isSubmitting: controller.isSubmitting.value,
                          isFormValid: controller.isFormValid,
                          onSubmit: controller.submitEvaluation,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}