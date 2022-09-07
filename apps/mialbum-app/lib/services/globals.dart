import 'package:flutter/material.dart';

class Global {
  // App static data
  static const String title = 'mialbum.co';
  static const primaryColor = Color(0xFFB6093D);
  static const primaryFont = Color(0xFF2B0748);
  static const secondaryColor = Color(0xFF550067);
  static const secondaryFont = Color(0xFF7B1232);
  static const pappColor = Color(0xff00D9FF);
  static const primaryGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFFB6093D),
      Color(0xFF7B1232),
    ],
  );
  static const secondaryGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF550067),
      Color(0xFF2B0748),
    ],
  );
}
