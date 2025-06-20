import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

BarChartData generateBarChartData({
  required RxList<String> selectedStats,
  required Map<String, Map<String, dynamic>> stats,
}) {
  return BarChartData(
    alignment: BarChartAlignment.spaceAround,
    barTouchData: BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            '${stats[selectedStats[rodIndex]]!['title']}: ${rod.toY.toInt()}',
            const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    ),
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF616161)),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final months = [
              'Jan'.tr, 'Feb'.tr, 'Mar'.tr, 'Apr'.tr, 'May'.tr, 'Jun'.tr,
              'Jul'.tr, 'Aug'.tr, 'Sep'.tr, 'Oct'.tr, 'Nov'.tr, 'Dec'.tr
            ];
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                months[value.toInt()],
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF616161)),
              ),
            );
          },
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),
    borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xFFE0E0E0))),
    minY: 0,
    maxY: selectedStats.isNotEmpty
        ? selectedStats
        .map((key) => (stats[key]!['data'] as List<int>).reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a > b ? a : b)
        .toDouble() +
        5
        : 5, // Fallback maxY when no stats are selected
    barGroups: List.generate(12, (index) {
      return BarChartGroupData(
        x: index,
        barRods: selectedStats.asMap().entries.map((entry) {
          final statKey = entry.value;
          return BarChartRodData(
            toY: (stats[statKey]!['data'] as List<int>)[index].toDouble(),
            color: stats[statKey]!['color'] as Color,
            width: selectedStats.isNotEmpty ? 10 / selectedStats.length : 10,
            borderRadius: BorderRadius.circular(4),
          );
        }).toList(),
      );
    }),
  );
}