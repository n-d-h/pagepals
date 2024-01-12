import 'package:flutter/material.dart';

class IconHelper {
  static IconData getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'search':
        return Icons.search;
      case 'add':
        return Icons.add;
      case 'heart':
        return Icons.favorite;
      case 'user':
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}