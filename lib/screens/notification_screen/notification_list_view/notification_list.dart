import 'package:flutter/material.dart';
import 'package:pagepals/screens/notification_screen/notification_helpers/notification_model.dart';
import 'package:pagepals/screens/notification_screen/notification_list_view/notification_tile.dart'; // Import the NotificationTile widget

class NotificationList extends StatelessWidget {
  final List<NotificationModel> notifications;
  final int unreadCount;
  final Function(int) onNotificationRead;

  const NotificationList({
    super.key,
    required this.notifications,
    required this.unreadCount,
    required this.onNotificationRead,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return NotificationTile(
                notification: notification,
                onRead: () => onNotificationRead(index),
              );
            },
          ),
        ),
        const SizedBox(height: 75),
      ],
    );
  }
}
