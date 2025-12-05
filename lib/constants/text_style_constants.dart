import 'package:flutter/material.dart';
import 'package:sadamov/constants/colors_constants.dart';

/// Classe de estilos de texto da aplicação
/// Fornece hierarquia tipográfica completa (display, headline, title, body)
class AppTextStyles {
  /// Estilo de texto display large (32px)
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

  /// Estilo de texto headline large (24px)
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

  /// Estilo de texto title large (20px)
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

  /// Estilo de texto title medium (18px)
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

  /// Estilo de texto body large (16px)
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

  /// Estilo de texto body medium (14px)
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

  /// Estilo de texto body small (12px)
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

/// Extensão para aplicar estilo de texto com contexto
extension TextStyleExtension on TextStyle {
  /// Retorna o estilo aplicado (usado para compatibilidade)
  TextStyle textStyle(BuildContext context) {
    return this;
  }
}

