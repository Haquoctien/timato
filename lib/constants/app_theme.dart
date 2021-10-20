import 'package:flutter/material.dart';

abstract class AppTheme {
  /// General background
  static const bg = Colors.white;

  /// General foreground
  static const fg = Colors.blue;

  static const checked = Colors.blue;

  static const chip = _Component(Color(0xFF7CC3F5), Colors.white);

  /// All fab buttons
  static const fab = _Component(Colors.blue, Colors.white);

  /// Active texts, like in text buttons
  static const activeText = _Component(Colors.white, Colors.blue);

  /// Cards, like todo item tile
  static const card = _Component(Colors.white, Colors.black);

  /// General texts
  static const text = _Component(Colors.white, Colors.black);

  /// Icons that are not in fabs
  static const icon = _Component(Colors.transparent, Colors.black);

  /// Countdown timer
  static const countdown = _Component(Colors.lightBlue, Colors.grey);

  /// Appbar
  static const appbar = _Component(Colors.blue, Colors.white);
}

class _Component {
  const _Component(this.bgColor, this.fgColor);
  final Color bgColor;
  final Color fgColor;
}
