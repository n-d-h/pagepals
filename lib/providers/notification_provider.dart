import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void setCount(int count) {
    _count = count;
    notifyListeners();
  }

  void increment()  {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if(_count > 0) _count--;
    notifyListeners();
  }
}