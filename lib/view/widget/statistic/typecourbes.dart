import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../conroller/statistic/statistic_controller.dart';


class Typecourbes extends StatelessWidget {
  const Typecourbes({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatisticsController>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Obx(() => DropdownMenu<String>(
          initialSelection: controller.chartType.value,
          onSelected: controller.updateChartType,
          dropdownMenuEntries:[
            DropdownMenuEntry(value: 'Line', label: 'Line Chart'.tr, leadingIcon: Icon(Icons.show_chart, color: Colors.black)),
            DropdownMenuEntry(value: 'Bar', label: 'Bar Chart'.tr, leadingIcon: Icon(Icons.bar_chart, color: Colors.black)),
            DropdownMenuEntry(value: 'Pie', label: 'Pie Chart'.tr, leadingIcon: Icon(Icons.pie_chart, color: Colors.black)),
          ],
          textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2196F3)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            elevation: WidgetStateProperty.all(4),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        )),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 250.ms);
  }
}