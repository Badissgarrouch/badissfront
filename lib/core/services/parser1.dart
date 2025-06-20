import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:credit_app/view/widget/notification/noti_type.dart';
import 'package:get/get.dart';

class NotificationParserService {
  Map<String, dynamic> notificationToJson(NotificationItem notification) {
    return {
      'id': notification.id,
      'type': notification.type.toString().split('.').last,
      'title': notification.title,
      'description': notification.description,
      'details': notification.details,
      'time': notification.time.toIso8601String(),
      'dueDate': notification.dueDate?.toIso8601String(),
      'status': notification.status?.toString().split('.').last,
      'isUrgent': notification.isUrgent,
      'isRead': notification.isRead,
    };
  }

  NotificationItem parseNotificationFromJson(Map<String, dynamic> item) {
    final backendToFrontendType = {
      'invitation_received': NotificationType.invitationReceived,
      'invitation_accepted': NotificationType.invitationAccepted,
      'credit_offer_received': NotificationType.creditOfferReceived,
      'credit_offer_accepted': NotificationType.creditOfferAccepted,
      'credit_offer_modification_requested': NotificationType.creditOfferModificationRequested,
      'credit_modified': NotificationType.creditModified,
      'payment_received': NotificationType.paymentReceived,
      'payment_late': NotificationType.paymentDue,
      'payment_upcoming': NotificationType.paymentVenir,
      'payment_overdue': NotificationType.paymentOverdue,
    };

    final typeStr = item['type']?.toString() ?? 'invitation_received';
    final type = backendToFrontendType[typeStr] ?? NotificationType.invitationReceived;

    NotificationStatus determineStatus(NotificationType type) {
      switch (type) {
        case NotificationType.invitationReceived:
          return NotificationStatus.pending;
        case NotificationType.invitationAccepted:
          return NotificationStatus.accepted;
        case NotificationType.creditOfferReceived:
          return NotificationStatus.pending;
        case NotificationType.creditOfferAccepted:
          return NotificationStatus.accepted;
        case NotificationType.creditOfferModificationRequested:
          return NotificationStatus.modificationRequested;
        case NotificationType.creditModified:
          return NotificationStatus.completed;
        case NotificationType.paymentReceived:
          return NotificationStatus.completed;
        case NotificationType.paymentDue:
          return NotificationStatus.pending;
        case NotificationType.paymentOverdue:
          return NotificationStatus.pending;
        case NotificationType.paymentVenir:
          return NotificationStatus.pending;
      }
    }

    String determineTitle(NotificationType type, dynamic message) {
      switch (type) {
        case NotificationType.invitationReceived:
          return 'Invitation received'.tr;
        case NotificationType.invitationAccepted:
          return 'Invitation accepted'.tr;
        case NotificationType.creditOfferReceived:
          return 'Offer proposed'.tr;
        case NotificationType.creditOfferAccepted:
          return 'Offer accepted'.tr;
        case NotificationType.creditModified:
          return 'Modified offer'.tr;
        case NotificationType.creditOfferModificationRequested:
          return 'Change request'.tr;
        case NotificationType.paymentReceived:
          return 'Payment received'.tr;
        case NotificationType.paymentDue:
          return 'Late payment'.tr;
        case NotificationType.paymentVenir:
          return 'Payment to come'.tr;
        case NotificationType.paymentOverdue:
          return 'Late payment (other)'.tr;
        default:
          return message?.toString().startsWith('null') ?? true
              ? 'New notification'.tr
              : message.toString();
      }
    }

    return NotificationItem(
      id: item['id']?.toString(),
      type: type,
      title: determineTitle(type, item['message'] ?? item['description']),
      description: item['message'] ?? item['description'] ?? 'No message',
      details: item['invitation'] != null
          ? 'De: ${item['invitation']['sender']['firstName']} ${item['invitation']['sender']['lastName']}'
          : item['details'] ?? item['message'],
      time: DateTime.tryParse(item['createdAt'] ?? item['time'] ?? '') ?? DateTime.now(),
      dueDate: item['dueDate'] != null ? DateTime.tryParse(item['dueDate']) : null,
      status: determineStatus(type),
      isUrgent: item['isUrgent'] ?? false,
      isRead: item['isRead'] ?? false,
    );
  }
}