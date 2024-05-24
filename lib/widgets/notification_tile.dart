import 'package:flutter/material.dart';
import '../models/notification_message.dart';

class NotificationTile extends StatelessWidget {
  final NotificationMessage notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: _buildLeadingIcon(),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              notification.body,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    if (notification.imageUrl != null) {
      return ClipOval(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(notification.imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      );
    }
  }
}
