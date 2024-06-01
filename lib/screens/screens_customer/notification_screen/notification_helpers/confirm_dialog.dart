import 'package:flutter/material.dart';

class ConfirmationDialog {
  static void show(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Read All'),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content:
              const Text('Are you sure you want to mark all messages as read?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
