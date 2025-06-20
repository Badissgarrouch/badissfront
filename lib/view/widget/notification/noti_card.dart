import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../conroller/notification/notification_controller.dart';
import 'format.dart';
import 'noti_items.dart';
import 'noti_type.dart';
import 'noti_utils.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    final config = getNotificationConfig(notification);
    final daysLate = extractDaysLate(notification.description);

    return Card(
      color: Colors.grey[200],
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: config.gradient,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              Icon(config.icon, color: Colors.white, size: 28, semanticLabel: getTypeName(notification.type)),
              if (notification.isUrgent)
                Positioned(
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red[800],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                  ),
                ),
            ],
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.blue[900],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              formatTime(notification.time),
              style: TextStyle(
                color: Colors.blueGrey[400],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              notification.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notification.type == NotificationType.paymentReceived) ...[
                  Text(
                    'Details:'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                  const SizedBox(height: 4),
                  Text('A transfer has been sent'.tr, style: TextStyle(color: Colors.blueGrey[700])),
                  const SizedBox(height: 8),
                ],
                if (notification.type == NotificationType.creditOfferModificationRequested) ...[
                  Text(
                    'Details:'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                  const SizedBox(height: 4),
                  Text('Your Merchant has offered to modify a detail of the offer'.tr, style: TextStyle(color: Colors.blueGrey[700])),
                  const SizedBox(height: 8),
                ],
                if (notification.type == NotificationType.creditModified) ...[
                  Text(
                    'Details:'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                  const SizedBox(height: 4),
                  Text('The offer has been modified'.tr, style: TextStyle(color: Colors.blueGrey[700])),
                  const SizedBox(height: 8),
                ],
                if (daysLate != null &&
                    (notification.type == NotificationType.paymentDue ||
                        notification.type == NotificationType.paymentOverdue))
                  Text(
                    'Delay: $daysLate day${daysLate > 1 ? 's' : ''}'.tr,
                    style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.w500),
                  ),
                if (notification.status != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: config.statusGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      getStatusName(notification.status!),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: [
                    if (notification.status == NotificationStatus.pending && !(notification.isRead ?? true)) // Modifier ici
                      TextButton(
                        onPressed: () {
                          print('Mark as read button clicked for notification ${notification.id}'.tr);
                          controller.handleNotificationAction('mark_as_read', notification);
                        },
                        child: Text('Mark as read'.tr, style: TextStyle(color: Colors.blue)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}