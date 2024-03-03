import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier  {
  int _cartCount = 0;

  int get cartCount => _cartCount;

  void addToCart() {
    _cartCount++;
    notifyListeners();
  }

  void removeFromCart() {
    _cartCount--;
    notifyListeners();
  }
}