import 'package:credit_app/core/services/storagenoti.dart';
import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:credit_app/view/widget/notification/noti_type.dart';
import 'package:http/http.dart' as http;
import 'package:credit_app/linkapi.dart';

class ActionService {
  final StorageService storageService;

  ActionService({required this.storageService});

  Future<void> handleNotificationAction(String action, NotificationItem notification, String userToken) async {
    try {
      print('Début de handleNotificationAction: action=$action, notificationId=${notification.id}');
      if (action == 'mark_as_read' && notification.id != null) {
        print('Marquage de la notification comme lue: ${notification.id}');
        String url;
        String method = 'PATCH';
        if ([
          NotificationType.invitationReceived,
          NotificationType.invitationAccepted,
        ].contains(notification.type)) {
          url = AppLink.markNotificationRead(notification.id!);
          print('Appel API (backend 1): $url');
        } else {
          url = AppLink.markNotificationRead2(notification.id!);
          method = 'PUT';
          print('Appel API (backend 2): $url');
        }

        final response = method == 'PATCH'
            ? await http.patch(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        )
            : await http.put(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        );

        print('Statut de la réponse: ${response.statusCode}');
        print('Corps de la réponse: ${response.body}');

        if (response.statusCode == 200) {
          final updatedNotification = NotificationItem(
            id: notification.id,
            type: notification.type,
            title: notification.title,
            description: notification.description,
            details: notification.details,
            time: notification.time,
            dueDate: notification.dueDate,
            status: notification.status, // Conserver le statut existant
            isUrgent: notification.isUrgent,
            isRead: true, // Mettre à jour uniquement isRead
          );
          await storageService.saveDynamicNotifications([updatedNotification], userToken);
          print('Notification ${notification.id} marquée comme lue avec succès');
        } else {
          print('Échec du marquage comme lue: ${response.body}');
        }
      } else {
        print('Action non supportée ou ID manquant: $action pour notification ${notification.id}');
      }
    } catch (e) {
      print('Erreur lors de la gestion de l’action: $e');
    }
  }
}