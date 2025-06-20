import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color getStatusColor(String status) {
  switch (status) {
    case 'acceptée':
    case 'accepted':
      return Colors.green;
    case 'refusée':
    case 'rejected':
      return Colors.red;
    case 'demande de modification':
    case 'modification requested':
      return Colors.orangeAccent;
    case 'en attente':
    case 'En Attente De Validation':
      return Colors.grey;
    default:
      return Colors.blue;
  }
}

String getStatusText(String status) {
  switch (status) {
    case 'accepted':
      return 'Accepted'.tr;
    case 'rejected':
      return 'Rejected'.tr;
    case 'modification requested':
      return 'Modification requested'.tr;
    case 'En Attente De Validation':
      return 'Pending'.tr;
    default:
      return status;
  }
}

String FormatStatusDate(String? dateString) {
  {
    if (dateString == null || dateString.isEmpty) return 'N/A';

    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month
          .toString()
          .padLeft(2, '0')}/${date.year} '
          '${"At".tr} ${date.hour.toString().padLeft(2, '0')}:${date.minute
          .toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString
          .split('T')
          .first;
    }
  }
}
