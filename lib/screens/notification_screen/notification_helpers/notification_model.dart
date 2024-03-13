import 'package:flutter/material.dart';

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