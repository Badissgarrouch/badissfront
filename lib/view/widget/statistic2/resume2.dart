import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../conroller/statistic/statistic2_controller.dart';

class Resume2 extends StatelessWidget {
  const Resume2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Statistics2Controller>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    'Summary'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Obx(() => Text(
                    "${'Total'.tr} : ${controller.totalTransactions}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212121),
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1, color: Color(0xFFE0E0E0)),
            Obx(() => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.selectedStats.map((key) {
                final total = (controller.stats[key]!['data'] as List<int>).reduce((a, b) => a + b);
                return Chip(
                  label: Text(
                    '${controller.stats[key]!['title']}: $total',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF424242),
                    ),
                  ),
                  backgroundColor: Color.fromRGBO(
                    (controller.stats[key]!['color'] as Color).red,
                    (controller.stats[key]!['color'] as Color).green,
                    (controller.stats[key]!['color'] as Color).blue,
                    0.15,
                  ),
                  avatar: CircleAvatar(
                    backgroundColor: controller.stats[key]!['color'] as Color,
                    radius: 10,
                    child: Icon(
                      controller.getIconForStat(key),
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }).toList(),
            )),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms);
  }
}