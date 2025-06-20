import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../conroller/statistic/statistic_controller.dart';


class Courbes extends StatelessWidget {
  const Courbes({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatisticsController>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 400,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => controller.selectedStats.isEmpty
            ? Center(
          child: Text(
            'No statistics selected'.tr,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF616161),
            ),
          ),
        )
            : controller.chartType.value == 'Pie'
            ? SizedBox(
          height: 350,
          child: PieChart(controller.buildPieChartData()),
        )
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(16.0),
            child: controller.chartType.value == 'Bar'
                ? BarChart(controller.buildBarChartData())
                : LineChart(controller.buildLineChartData()),
          ),
        )),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}