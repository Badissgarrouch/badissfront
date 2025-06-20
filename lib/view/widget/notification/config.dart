import 'package:flutter/material.dart';
import 'noti_type.dart';
LinearGradient getStatusGradient(NotificationStatus status) {
  switch (status) {
    case NotificationStatus.pending:
      return LinearGradient(colors: [Colors.blue[300]!, Colors.blue[600]!]);
    case NotificationStatus.accepted:
      return LinearGradient(colors: [Colors.green[400]!, Colors.green[700]!]);
    case NotificationStatus.modificationRequested:
      return LinearGradient(colors: [Colors.orange[400]!, Colors.orange[700]!]);
    case NotificationStatus.completed:
      return LinearGradient(colors: [Colors.green[500]!, Colors.green[800]!]);
  }
}