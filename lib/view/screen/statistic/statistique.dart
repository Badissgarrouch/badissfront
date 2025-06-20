import 'package:credit_app/view/widget/statistic/courbes.dart';
import 'package:credit_app/view/widget/statistic/resume.dart';
import 'package:credit_app/view/widget/statistic/typecourbes.dart';
import 'package:credit_app/view/widget/statistic/typestatistic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../conroller/statistic/statistic_controller.dart';
import '../../../core/class/statusrequest.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final String? token = Get.arguments?['token'] as String?;
    Get.put(StatisticsController(token: token));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics'.tr,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2E3A4D),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F7FA), Color(0xFFE8ECEF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          final controller = Get.find<StatisticsController>();
          if (controller.statusRequest.value == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.statusRequest.value == StatusRequest.success) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Annual Overview'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2E3A4D),
                      ),
                    ).animate().fadeIn(duration: 600.ms),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Track your activity trends over the year'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF6C757D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Typestatistic(),
                  const SizedBox(height: 20),
                  const Courbes(),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Choose the type of curve you prefer to see'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2E3A4D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(child: Typecourbes()),
                  const SizedBox(height: 20),
                  const Resume(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (controller.statusRequest.value == StatusRequest.authfailure) {
            return  Center(child: Text('Session expired. Please log in again.'.tr));
          } else {
            return Center(child: Text('Erreur: ${controller.statusRequest.value}'));
          }
        }),
      ),
    );
  }
}