import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/models/notification_message.dart';
import 'package:flutter_firebase_notifications/providers/notification_provider.dart';
import 'package:flutter_firebase_notifications/widgets/notification_tile.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final List<NotificationMessage> notifications = notificationProvider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'No notifications yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationTile(notification: notifications[index]);
              },
            ),
    );
  }
}
