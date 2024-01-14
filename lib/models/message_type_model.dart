import 'package:flutter/material.dart';

class MessageTypeModel {
  final IconData? icon;
  final String name;
  late final bool isChecked;

  MessageTypeModel({
    this.icon,
    required this.name,
    required this.isChecked,
  });

  factory MessageTypeModel.fromJson(Map<String, dynamic> json) {
    return MessageTypeModel(
      icon: json['icon'],
      name: json['name'],
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() => {
    'icon': icon,
    'name': name,
    'isChecked': isChecked,
  };
}
