import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:credit_app/view/widget/notification/noti_type.dart';

class StaticNotificationService {
  List<NotificationItem> getInitialNotifications() {
    return [
      NotificationItem(
        id: 'static_1',
        type: NotificationType.creditOfferReceived,
        title: "Offre proposée",
        description: "Badiss vous a proposé une offre de crédit",
        time: DateTime.now().subtract(Duration(minutes: 1)),
        status: NotificationStatus.pending,
        isUrgent: false,
      ),
      NotificationItem(
        id: 'static_2',
        type: NotificationType.paymentReceived,
        title: "Paiement reçu",
        description: "Paiement de 500 euro de Moez Grissa",
        details: "Virement a été envoyé",
        status: NotificationStatus.completed,
        time: DateTime.now().subtract(Duration(minutes: 1)),
        isUrgent: false,
      ),
      NotificationItem(
        id: 'static_3',
        type: NotificationType.paymentVenir,
        title: "Paiement Bientôt",
        description: "Paiement de 500 euro de Moez Grissa",
        details: "Le délai est proche pour payer",
        time: DateTime.now().subtract(Duration(days: 17)),
        isUrgent: false,
      ),
      NotificationItem(
        id: 'static_4',
        type: NotificationType.creditOfferModificationRequested,
        title: "Demande de modification",
        description: "Sotudev a demandé de modifier votre offre",
        details: "La durée n'est pas appropriée",
        status: NotificationStatus.modificationRequested,
        time: DateTime.now().subtract(Duration(days: 2)),
        isUrgent: false,
      ),
      NotificationItem(
        id: 'static_5',
        type: NotificationType.creditOfferAccepted,
        title: "Offre acceptée",
        description: "DesignCo a accepté votre offre de crédit.",
        details: "Crédit de 3000€ approuvé.",
        time: DateTime.now().subtract(Duration(days: 1)),
        isUrgent: false,
      ),
      NotificationItem(
        id: 'static_6',
        type: NotificationType.creditOfferModificationRequested,
        title: "Demande de modification",
        description: "AICorp a demandé une modification de l'offre.",
        details: "Augmenter à 7000€, durée 18 mois.",
        time: DateTime.now().subtract(Duration(days: 15)),
        status: NotificationStatus.modificationRequested,
        isUrgent: false,
      ),
      NotificationItem(
        id: 'static_7',
        type: NotificationType.paymentReceived,
        title: "Paiement reçu",
        description: "Paiement de 1500€ reçu.",
        details: "Virement pour consulting UX.",
        time: DateTime.now().subtract(Duration(days: 27)),
        status: NotificationStatus.completed,
        isUrgent: false,
      ),
      NotificationItem(
        id: 'static_8',
        type: NotificationType.paymentDue,
        title: "Paiement en retard",
        description: "Vous êtes en retard de 10 jours pour payer.",
        details: "Payer 2000€ avant le 20/05/2025.",
        time: DateTime.now().subtract(Duration(days: 90)),
        isUrgent: true,
      ),
      NotificationItem(
        id: 'static_9',
        type: NotificationType.paymentOverdue,
        title: "Paiement en retard",
        description: "Paiement en retard de 15 jours.",
        details: "Paiement attendu de 2500€.",
        time: DateTime.now().subtract(Duration(days: 1)),
        isUrgent: true,
      ),
    ];
  }
}