import 'package:flutter/material.dart';

class TodoColor {
  static const Color Red = Color(0xFFFF8680);
  static const Color Violet = Color(0xFFB384E2);
  static const Color Indigo = Color(0xFF7A99DC);
  static const Color Teal = Color(0xFF76D6D6);

  static Color getColor(int code) {
    switch (code) {
      case 0:
        return Red;
      case 1:
        return Violet;
      case 2:
        return Indigo;
      case 3:
        return Teal;
      default:
        return Colors.blueGrey;
    }
  }
}
