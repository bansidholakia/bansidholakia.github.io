import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const background = Color(0xFF0A0A0B);
  static const surface = Color(0xFF111214);
  static const surfaceSoft = Color(0xFF18191C);
  static const text = Color(0xFFF4F4F5);
  static const muted = Color(0xFFA1A1AA);
  static const accent = Color(0xFFFF4F64);
  static const border = Color(0xFF2B2C31);
}

ThemeData buildTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.accent,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    ),
    dividerColor: AppColors.border,
  );
}
