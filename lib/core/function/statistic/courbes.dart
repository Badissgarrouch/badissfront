import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

LineChartData generateLineChartData({
  required RxList<String> selectedStats,
  required Map<String, Map<String, dynamic>> stats,
}) {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 5,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) => const FlLine(color: Color(0xFFE0E0E0), strokeWidth: 1),
      getDrawingVerticalLine: (value) => const FlLine(color: Color(0xFFE0E0E0), strokeWidth: 1),
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
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: selectedStats.isNotEmpty
        ? selectedStats
        .map((key) => (stats[key]!['data'] as List<int>).reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a > b ? a : b)
        .toDouble() +
        5
        : 5, // Fallback maxY when no stats are selected
    lineBarsData: selectedStats.map((key) {
      return LineChartBarData(
        spots: List.generate(
          (stats[key]!['data'] as List<int>).length,
              (index) => FlSpot(index.toDouble(), (stats[key]!['data'] as List<int>)[index].toDouble()),
        ),
        isCurved: true,
        color: stats[key]!['color'] as Color,
        barWidth: 3,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 4,
            color: stats[key]!['color'] as Color,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ),
        belowBarData: BarAreaData(
          show: true,
          color: Color.fromRGBO(
            (stats[key]!['color'] as Color).red,
            (stats[key]!['color'] as Color).green,
            (stats[key]!['color'] as Color).blue,
            0.2,
          ),
        ),
      );
    }).toList(),
  );
}