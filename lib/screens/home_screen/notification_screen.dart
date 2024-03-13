import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int unreadCount = 10; // Sample unread count
  late List<NotificationModel> notifications;

  @override
  void initState() {
    super.initState();
    notifications = generateNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Handle unread notifications
                },
              ),
              if (unreadCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text(
                      '$unreadCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Messages',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                showConfirmationDialog(context);
              },
              child: Text('Read All ($unreadCount)'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        notification.isRead ? Colors.grey : Colors.blue,
                    child: Icon(
                      notification.icon,
                      color: notification.isRead ? Colors.white : Colors.black,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        style: TextStyle(
                          color:
                              notification.isRead ? Colors.grey : Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification.time,
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      if (!notification.isRead) {
                        unreadCount--;
                        notification.isRead = true;
                      }
                    });
                    // Navigate to message details screen or perform any action
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Read All'),
          content: Text('Are you sure you want to mark all messages as read?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notifications.forEach((n) => n.isRead = true);
                  unreadCount = 0;
                });
                Navigator.pop(context);
              },
              child: Text('Yes, Read All'),
            ),
          ],
        );
      },
    );
  }

  List<NotificationModel> generateNotifications() {
    List<NotificationModel> notifications = [];
    for (int i = 0; i < 10; i++) {
      notifications.add(
        NotificationModel(
          icon: Icons.notifications,
          title: 'Notification $i',
          message: 'This is a sample notification message for Notification $i',
          time: '${DateTime.now().subtract(Duration(hours: i)).toString()}',
        ),
      );
    }
    return notifications;
  }
}

class NotificationModel {
  final IconData icon;
  final String title;
  final String message;
  final String time;
  bool isRead;

  NotificationModel({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}
