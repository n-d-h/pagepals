import 'package:flutter/material.dart';
import 'package:pagepals/screens/notification_screen/notification_helpers/notification_helper.dart';
import 'package:pagepals/screens/notification_screen/notification_helpers/notification_model.dart'; // Import the NotificationModel

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onRead;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 8.0,
        ),
        leading: CircleAvatar(
          backgroundColor:
              notification.isRead ? Colors.grey : Colors.greenAccent,
          child: Icon(
            notification.isRead
                ? notification.icon
                : Icons.notifications_active,
            color: notification.isRead ? Colors.white : Colors.black,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              notification.title,
              style: TextStyle(
                fontWeight:
                    notification.isRead ? FontWeight.normal : FontWeight.bold,
                fontSize: 14,
              ),
            ),
            if (!notification.isRead)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    // Define your gradient colors
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: TextStyle(
                color: notification.isRead ? Colors.grey : Colors.black,
                fontSize: 12,
                fontWeight:
                    notification.isRead ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formatTime(notification.time),
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        onTap: onRead,
      ),
    );
  }
}
