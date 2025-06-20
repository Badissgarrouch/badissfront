import 'package:credit_app/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusConstants {
  static const Map<String, Color> statusColors = {
    'accepted': Colors.green,
    'rejected': Colors.red,
    'modification requested': Colors.orange,
    'En Attente De Validation': Colors.blue,
  };

  static const Map<String, LinearGradient> statusGradients = {
    'accepted': LinearGradient(
      colors: [Colors.green, Colors.greenAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'rejected': LinearGradient(
      colors: [Colors.red, Colors.redAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'modification requested': LinearGradient(
      colors: [Colors.orange, Colors.orangeAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'En Attente De Validation': LinearGradient(
      colors: [AppColors.primaryBlue, AppColors.darkBlue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  };

  static const Map<String, IconData> statusIcons = {
    'accepted': Icons.check_circle,
    'rejected': Icons.cancel,
    'modification requested': Icons.edit,
    'En Attente De Validation': Icons.access_time,
  };

  static  Map<String, String> statusLabels = {
    'accepted': 'Accepted'.tr,
    'rejected': 'Refused'.tr,
    'modification requested': 'Modification Requested'.tr,
    'En Attente De Validation': 'Pending'.tr,
  };
}