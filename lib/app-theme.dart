import 'package:flutter/material.dart';

class AppTheme {
  static const primaryBoxDecoration =
      BoxDecoration(gradient: AppTheme.primaryBarGradient);
  static const primaryBarGradient = LinearGradient(
    colors: [
      Color(0xb3cc7b7b),
      Color(0xb3d36a6a),
    ],
  );
}
