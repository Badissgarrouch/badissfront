import 'package:credit_app/linkapi.dart';
import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:credit_app/core/services/parser1.dart';

class DynamicNotificationService {
  final NotificationParserService parserService;

  DynamicNotificationService({required this.parserService});

  Future<List<NotificationItem>> fetchDynamicNotifications(String userToken) async {
    try {
      print('Fetching notifications from ${AppLink.notification} with token: $userToken');
      final response = await http.get(
        Uri.parse(AppLink.notification),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      print('Response status (backend 1): ${response.statusCode}');
      print('Response body (backend 1): ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] == null || data['data']['notifications'] == null) {
          print('Erreur: Aucune notification trouvée (backend 1)');
          return [];
        }
        final notifications = (data['data']['notifications'] as List)
            .map((item) => parserService.parseNotificationFromJson(item))
            .whereType<NotificationItem>()
            .toList();
        print('Notifications récupérées (backend 1): ${notifications.length}');
        return notifications;
      } else {
        print('Échec de la récupération (backend 1): ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération (backend 1): $e');
      return [];
    }
  }

  Future<List<NotificationItem>> fetchDynamicNotifications2(String userToken) async {
    try {
      print('Fetching notifications from ${AppLink.notifications2} with token: $userToken');
      final response = await http.get(
        Uri.parse(AppLink.notifications2),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      print('Response status (backend 2): ${response.statusCode}');
      print('Response body (backend 2): ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] == null) {
          print('Erreur: Aucune notification trouvée (backend 2)');
          return [];
        }
        final notifications = (data['data'] as List)
            .map((item) => parserService.parseNotificationFromJson(item))
            .whereType<NotificationItem>()
            .toList();
        print('Notifications récupérées (backend 2): ${notifications.length}');
        return notifications;
      } else {
        print('Échec de la récupération (backend 2): ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erreur lors de la récupération (backend 2): $e');
      return [];
    }
  }
}