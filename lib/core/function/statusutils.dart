import 'package:credit_app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import '../constant/status.dart';


class StatusUtils {
  static Color getStatusColor(String status) {
    final normalizedStatus = status.toLowerCase();
    return StatusConstants.statusColors[normalizedStatus] ?? Colors.grey;
  }

  static LinearGradient getStatusGradient(String status) {
    final normalizedStatus = status.toLowerCase();
    return StatusConstants.statusGradients[normalizedStatus] ??
        const LinearGradient(colors: [AppColors.primaryBlue, AppColors.darkBlue]);
  }

  static IconData getStatusIcon(String status) {
    final normalizedStatus = status.toLowerCase();
    return StatusConstants.statusIcons[normalizedStatus] ?? Icons.help_outline;
  }

  static String getStatusLabel(String status) {
    final normalizedStatus = status.toLowerCase();
    return StatusConstants.statusLabels[normalizedStatus] ?? status;
  }
}