import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/io.dart';
import 'package:credit_app/view/widget/notification/noti_items.dart';
import 'package:credit_app/core/services/parser1.dart';
import 'package:credit_app/linkapi.dart';

class WebSocketService {
  IO.Socket? socket1; // First backend (Socket.IO)
  IOWebSocketChannel? socket2; // Second backend (ws)
  final NotificationParserService parserService;

  WebSocketService({required this.parserService});

  void connectWebSocket(
      void Function(NotificationItem) onNewNotification, {
        void Function(bool)? onConnectionStatus,
        required String userToken,
        required String server, // 'first' or 'second'
      }) {
    if (userToken.isEmpty) {
      print('No token available for WebSocket connection ($server)');
      onConnectionStatus?.call(false);
      return;
    }

    try {
      if (server == 'first') {
        // Handle first backend with Socket.IO
        if (socket1 != null && socket1!.connected) {
          print('Socket.IO already connected (first backend)');
          onConnectionStatus?.call(true);
          return;
        }

        socket1 = IO.io(
          AppLink.socketServer,
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .setExtraHeaders({'Authorization': 'Bearer $userToken'})
              .setQuery({'token': userToken})
              .build(),
        );

        socket1!.onConnect((_) {
          print('Socket.IO connected (first backend)');
          socket1?.emit('authenticate', userToken);
          onConnectionStatus?.call(true);
        });

        socket1!.on('new_notification', (data) {
          try {
            if (data is! Map) throw Exception('Invalid notification format (first backend)');
            final notification = parserService.parseNotificationFromJson(Map<String, dynamic>.from(data));
            onNewNotification(notification);
            print('Received and processed notification (first backend): ${notification.title}');
          } catch (e) {
            print('Error processing notification (first backend): $e');
          }
        });

        socket1!.onConnectError((error) {
          print('Socket.IO connect error (first backend): $error');
          onConnectionStatus?.call(false);
        });

        socket1!.onError((error) {
          print('Socket.IO error (first backend): $error');
          onConnectionStatus?.call(false);
        });

        socket1!.onDisconnect((_) {
          print('Socket.IO disconnected (first backend)');
          onConnectionStatus?.call(false);
        });
      } else if (server == 'second') {
        // Handle second backend with ws
        if (socket2 != null) {
          print('WebSocket already connected (second backend)');
          onConnectionStatus?.call(true);
          return;
        }

        // Connect using web_socket_channel with token in query
        socket2 = IOWebSocketChannel.connect(
          Uri.parse('${AppLink.socketServer2}?token=$userToken'),
          headers: {'Authorization': 'Bearer $userToken'},
        );

        // Listen to WebSocket stream
        socket2!.stream.listen(
              (data) {
            try {
              final parsedData = jsonDecode(data);
              if (parsedData['type'] == 'notification') {
                final notification = parserService.parseNotificationFromJson(
                  Map<String, dynamic>.from(parsedData['data']),
                );
                onNewNotification(notification);
                print('Received and processed notification (second backend): ${notification.title}');
              } else if (parsedData['type'] == 'connected') {
                print('WebSocket connected (second backend): ${parsedData['message']}');
                onConnectionStatus?.call(true);
              }
            } catch (e) {
              print('Error processing notification (second backend): $e');
            }
          },
          onError: (error) {
            print('WebSocket error (second backend): $error');
            onConnectionStatus?.call(false);
          },
          onDone: () {
            print('WebSocket disconnected (second backend)');
            socket2 = null;
            onConnectionStatus?.call(false);
          },
        );
      } else {
        print('Invalid server specified');
        onConnectionStatus?.call(false);
      }
    } catch (e) {
      print('WebSocket connection error ($server): $e');
      onConnectionStatus?.call(false);
    }
  }

  void disconnectWebSocket() {
    try {
      if (socket1 != null) {
        socket1!.disconnect();
        socket1!.clearListeners();
        socket1 = null;
        print('Socket.IO successfully disconnected (first backend)');
      }
      if (socket2 != null) {
        socket2!.sink.close();
        socket2 = null;
        print('WebSocket successfully disconnected (second backend)');
      }
    } catch (e) {
      print('Error disconnecting WebSocket: $e');
    }
  }
}