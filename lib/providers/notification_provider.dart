import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/models/notification_message.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationMessage> _notifications = [];

  void addNotification(NotificationMessage message) {
    _notifications.insert(0, message);
    notifyListeners();
  }

  List<NotificationMessage> get notifications => _notifications;
}
