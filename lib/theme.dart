import 'package:flutter/material.dart';
import 'package:sadamov/constants/colors_constants.dart';

/// Configura o tema claro da aplicação
ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ThemeColor.actionPrimaryColor.color(context),
      surface: ThemeColor.surfacesBackground.color(context),
    ),
    scaffoldBackgroundColor: ThemeColor.surfacesBackground.color(context),
  );
}

/// Configura o tema escuro da aplicação
ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: ThemeColor.actionPrimaryColor.color(context),
      surface: ThemeColor.surfacesBackground.color(context),
    ),
    scaffoldBackgroundColor: ThemeColor.surfacesBackground.color(context),
  );
}

