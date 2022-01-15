//SHA 1: 19:38:E2:9E:55:BB:AE:D7:5C:C6:3B:AD:8D:DF:68:FA:94:C0:B3:E4

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('onBackground Handler ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('onMessageOpenApp Handler ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    //Push Notifications
    await Firebase.initializeApp();

    token = await FirebaseMessaging.instance.getToken();
    print("Token: $token");

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //LocalNotification
  }

  static closeStreams() {
    _messageStream.close();
  }
}
