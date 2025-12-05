import 'package:flutter/material.dart';

/// Enum de cores do tema da aplicação
/// Suporta modo claro e escuro automaticamente
enum ThemeColor {
  // Surfaces
  surfacesElevate,
  surfacesBackground,
  surfacesFields,

  // Text
  textPrimaryColor,
  textSecondaryColor,
  textTitlesColor,
  textTextErrors,

  // Actions
  actionPrimaryColor,
  actionDisabled,

  // Borders
  borderDefault,

  // Transparent
  transparent,
}

/// Extensão que retorna a cor baseada no tema atual (claro/escuro)
extension ThemeColorExtension on ThemeColor {
  /// Retorna a cor correspondente ao tema atual
  Color color(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (this) {
      case ThemeColor.surfacesElevate:
        return isDark ? const Color(0xFF1E1E1E) : Colors.white;
      case ThemeColor.surfacesBackground:
        return isDark ? const Color(0xFF121212) : const Color(0xFFF5F6FA);
      case ThemeColor.surfacesFields:
        return isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF6F6FB);

      case ThemeColor.textPrimaryColor:
        return isDark ? Colors.white : const Color(0xFF1A1A1A);
      case ThemeColor.textSecondaryColor:
        return isDark ? const Color(0xFFB0B0B0) : const Color(0xFF666666);
      case ThemeColor.textTitlesColor:
        return isDark ? Colors.white : const Color(0xFF000000);
      case ThemeColor.textTextErrors:
        return const Color(0xFFE53935);

      case ThemeColor.actionPrimaryColor:
        return const Color(0xFF006E63);
      case ThemeColor.actionDisabled:
        return isDark ? const Color(0xFF424242) : const Color(0xFFE5E7EB);

      case ThemeColor.borderDefault:
        return const Color(0xFFDFE4EA);

      case ThemeColor.transparent:
        return Colors.transparent;
    }
  }
}
