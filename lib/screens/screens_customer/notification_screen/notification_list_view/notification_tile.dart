import 'package:flutter/material.dart';
import 'package:pagepals/models/notification_model.dart';
import 'package:pagepals/screens/screens_customer/notification_screen/notification_helpers/notification_helper.dart';

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onRead;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    bool isRead = notification.isRead == true;
    String createdAt = notification.createdAt ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        splashColor: Colors.transparent,
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
          backgroundColor: isRead ? Colors.grey : Colors.greenAccent,
          child: Icon(
            isRead ? Icons.notifications_off : Icons.notifications_active,
            color: isRead ? Colors.white : Colors.black,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pagepal Notification",
              style: TextStyle(
                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                fontSize: 14,
              ),
            ),
            if (!isRead)
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
              notification.content ?? "",
              style: TextStyle(
                color: isRead ? Colors.grey : Colors.black,
                fontSize: 12,
                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formatTime(createdAt),
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
