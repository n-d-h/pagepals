import 'package:flutter/material.dart';
import 'package:pagepals/screens/notification_screen/notification_widgets/app_bar_action.dart';
import 'package:pagepals/screens/notification_screen/notification_widgets/app_bar_bottom.dart';
import 'package:pagepals/screens/notification_screen/notification_helpers/confirm_dialog.dart';
import 'package:pagepals/screens/notification_screen/notification_list_view/notification_list.dart';
import 'package:pagepals/screens/notification_screen/notification_helpers/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
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
        toolbarHeight: 90,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [NotificationAppBarAction(unreadCount: unreadCount)],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: NotificationAppBarBottom(
            unreadCount: unreadCount,
            onReadAllPressed: () {
              _showConfirmationDialog();
            },
          ),
        ),
      ),
      body: NotificationList(
        notifications: notifications,
        unreadCount: unreadCount,
        onNotificationRead: (index) {
          setState(() {
            notifications[index].isRead = true;
            unreadCount--;
          });
        },
      ),
    );
  }

  void _showConfirmationDialog() {
    ConfirmationDialog.show(context, () {
      setState(() {
        notifications.forEach((n) => n.isRead = true);
        unreadCount = 0;
      });
    });
  }

  List<NotificationModel> generateNotifications() {
    List<NotificationModel> notifications = [];
    for (int i = 0; i < 10; i++) {
      notifications.add(
        NotificationModel(
          icon: Icons.notifications_off,
          title: 'Notification $i',
          message: 'This is a sample notification message for Notification $i',
          time: DateTime.now()
              .subtract(
                Duration(
                  days: i,
                  hours: i * 2,
                ),
              )
              .toString(),
        ),
      );
    }
    return notifications;
  }
}
