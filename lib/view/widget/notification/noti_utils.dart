import 'package:credit_app/view/widget/notification/config.dart';
import 'package:flutter/material.dart';
import 'noti_items.dart';
import 'noti_type.dart';

int? extractDaysLate(String description) {
  final regex = RegExp(r'en retard de (\d+) jours');
  final match = regex.firstMatch(description);
  return match != null ? int.parse(match.group(1)!) : null;
}

String getTypeName(NotificationType type) {
  return {
    NotificationType.invitationReceived: 'Invitations reçues',
    NotificationType.invitationAccepted: 'Invitations acceptées',
    NotificationType.creditOfferReceived: 'Offres de crédit reçues',
    NotificationType.creditOfferAccepted: 'Offres de crédit acceptées',
    NotificationType.creditOfferModificationRequested: 'Modifications d\'offres demandées',
    NotificationType.creditModified:'Offre modifié',
    NotificationType.paymentReceived: 'Paiements reçus',
    NotificationType.paymentVenir: 'Paiements A Venir',
    NotificationType.paymentDue: 'Paiements en retard (vous)',
    NotificationType.paymentOverdue: 'Paiements en retard (autres)',
  }[type]!;
}

String getStatusName(NotificationStatus status) {
  return {
    NotificationStatus.pending: 'EN ATTENTE',
    NotificationStatus.accepted: 'ACCEPTÉ',
    NotificationStatus.modificationRequested: 'MODIFICATION',
    NotificationStatus.completed: 'TERMINÉ',
  }[status]!;
}

({IconData icon, LinearGradient gradient, LinearGradient statusGradient}) getNotificationConfig(
    NotificationItem notification) {
  final defaultGradient = LinearGradient(colors: [Colors.blue[400]!, Colors.blue[700]!]);
  switch (notification.type) {
    case NotificationType.invitationReceived:
      return (
      icon: Icons.person_add,
      gradient: defaultGradient,
      statusGradient: getStatusGradient(notification.status ?? NotificationStatus.pending),
      );
    case NotificationType.invitationAccepted:
      return (
      icon: Icons.check_box_rounded,
      gradient: LinearGradient(colors: [Colors.blue[300]!, Colors.blue[600]!]),
      statusGradient: getStatusGradient(notification.status ?? NotificationStatus.accepted),
      );
    case NotificationType.creditOfferReceived:
      return (
      icon: Icons.account_balance_wallet,
      gradient: LinearGradient(colors: [Colors.orange[400]!, Colors.orange[700]!]),
      statusGradient: defaultGradient,
      );
    case NotificationType.creditOfferAccepted:
      return (
      icon: Icons.account_balance,
      gradient: LinearGradient(colors: [Colors.green[400]!, Colors.green[700]!]),
      statusGradient: defaultGradient,
      );
    case NotificationType.creditOfferModificationRequested:
      return (
      icon: Icons.edit,
      gradient: LinearGradient(colors: [Colors.orange[400]!, Colors.orange[700]!]),
      statusGradient: getStatusGradient(notification.status ?? NotificationStatus.modificationRequested),
      );
    case NotificationType.paymentReceived:
      return (
      icon: Icons.payment,
      gradient: LinearGradient(colors: [Colors.green[400]!, Colors.green[700]!]),
      statusGradient: getStatusGradient(notification.status ?? NotificationStatus.completed),
      );
    case NotificationType.paymentVenir:
      return (
      icon: Icons.warning_amber,
      gradient: LinearGradient(colors: [Colors.yellow[400]!, Colors.yellow[700]!]),
      statusGradient:defaultGradient
      );
    case NotificationType.creditModified:
      return (
      icon: Icons.check_box,
      gradient: LinearGradient(colors: [Colors.orange[400]!, Colors.orange[700]!]),
      statusGradient:defaultGradient
      );
    case NotificationType.paymentDue:
    case NotificationType.paymentOverdue:
      return (
      icon: Icons.warning_amber,
      gradient: LinearGradient(colors: [Colors.red[400]!, Colors.red[700]!]),
      statusGradient: defaultGradient,
      );
  }
}