import 'package:flutter/material.dart';
import 'package:sadamov/constants/colors_constants.dart';

class AppTextStyles {
  static TextStyle displayLarge({
    BuildContext? context,
    bool bold = false,
  }) {
    return TextStyle(
      fontSize: 32,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: context != null 
          ? ThemeColor.textPrimaryColor.color(context) 
          : null,
    );
  }

  static TextStyle headlineLarge({
    BuildContext? context,
    bool bold = false,
  }) {
    return TextStyle(
      fontSize: 24,
      fontWeight: bold ? FontWeight.bold : FontWeight.w600,
      color: context != null 
          ? ThemeColor.textPrimaryColor.color(context) 
          : null,
    );
  }

  static TextStyle titleLarge({
    BuildContext? context,
    bool bold = false,
  }) {
    return TextStyle(
      fontSize: 20,
      fontWeight: bold ? FontWeight.bold : FontWeight.w600,
      color: context != null 
          ? ThemeColor.textTitlesColor.color(context) 
          : null,
    );
  }

  static TextStyle titleMedium({
    BuildContext? context,
    bool bold = false,
  }) {
    return TextStyle(
      fontSize: 18,
      fontWeight: bold ? FontWeight.bold : FontWeight.w600,
      color: context != null 
          ? ThemeColor.textTitlesColor.color(context) 
          : null,
    );
  }

  static TextStyle bodyLarge({
    BuildContext? context,
    bool bold = false,
  }) {
    return TextStyle(
      fontSize: 16,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: context != null 
          ? ThemeColor.textPrimaryColor.color(context) 
          : null,
    );
  }

  static TextStyle bodyMedium({
    BuildContext? context,
    bool bold = false,
  }) {
    return TextStyle(
      fontSize: 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: context != null 
          ? ThemeColor.textPrimaryColor.color(context) 
          : null,
    );
  }

  static TextStyle bodySmall({
    BuildContext? context,
    bool bold = false,
  }) {
    return TextStyle(
      fontSize: 12,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: context != null 
          ? ThemeColor.textSecondaryColor.color(context) 
          : null,
    );
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle textStyle(BuildContext context) {
    return this;
  }
}

