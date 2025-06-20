import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/function/statusutils.dart';

class StatusHeader extends StatelessWidget {
  final String status;
  final String date;

  const StatusHeader({
    super.key,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = StatusUtils.getStatusColor(status);
    final gradient = StatusUtils.getStatusGradient(status);
    final icon = StatusUtils.getStatusIcon(status);
    final label = StatusUtils.getStatusLabel(status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Request from $date".tr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}