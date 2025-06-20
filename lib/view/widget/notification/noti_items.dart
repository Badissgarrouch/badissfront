import 'noti_type.dart';

class NotificationItem {
  final String? id;
  final NotificationType type;
  final String title;
  final String description;
  final String? details;
  final DateTime time;
  final DateTime? dueDate;
  NotificationStatus? status;
  final bool isUrgent;
  bool? isRead;

  NotificationItem({
    this.id,
    required this.type,
    required this.title,
    required this.description,
    this.details,
    required this.time,
    this.dueDate,
    this.status,
    this.isUrgent = false,
    this.isRead =false,
  });
}