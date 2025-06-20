import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

PieChartData generatePieChartData({
  required RxList<String> selectedStats,
  required Map<String, Map<String, dynamic>> stats,
  required IconData Function(String) getIconForStat,
}) {
  return PieChartData(
    sectionsSpace: 3,
    centerSpaceRadius: 50,
    sections: selectedStats.asMap().entries.map((entry) {
      final key = entry.value;
      final total = (stats[key]!['data'] as List<int>).reduce((a, b) => a + b).toDouble();
      return PieChartSectionData(
        color: stats[key]!['color'] as Color,
        value: total,
        title: total.toInt().toString(),
        radius: 80,
        titleStyle: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        badgePositionPercentageOffset: 1.2,
      );
    }).toList(),
    pieTouchData: PieTouchData(
      touchCallback: (FlTouchEvent event, pieTouchResponse) {
        if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
          return;
        }
      },
    ),
  );
}