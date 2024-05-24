import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/notification_message.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final String? fcmToken = await _firebaseMessaging.getToken();
      debugPrint("FCM Token: $fcmToken");

      _setupForegroundNotificationHandler();
      _setupBackgroundNotificationHandler();
    } else {
      debugPrint("User declined or has not accepted permission");
    }
  }

  void _setupForegroundNotificationHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });
  }

  void _setupBackgroundNotificationHandler() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });
  }

  void _handleMessage(RemoteMessage? message) {
    if (message != null) {
      final notificationMessage = NotificationMessage(
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        imageUrl: message.notification?.android?.imageUrl,
      );
      final notificationProvider = Provider.of<NotificationProvider>(navigatorKey.currentContext!, listen: false);
      notificationProvider.addNotification(notificationMessage);
      navigatorKey.currentState?.pushNamed('/notificationsScreen');
    }
  }
}
