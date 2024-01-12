import 'package:flutter/material.dart';

class ColorHelper {
  static const String light = '#e6f0ef';
  static const String lightHover = '#d9e9e7';
  static const String lightActive = '#b0d1cc';
  static const String normal = '#00695c';
  static const String normalHover = '#005f53';
  static const String normalActive = '#00544a';
  static const String dark = '#004f45';
  static const String darkHover = '#003f37';
  static const String darkActive = '#002f29';
  static const String darker = '#002520';

  Color getColor(String colorCode) {
    colorCode = colorCode.substring(1);
    return Color(int.parse("0xff$colorCode"));
  }
}