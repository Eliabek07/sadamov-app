import 'package:flutter/material.dart';
import 'package:sadamov/constants/colors_constants.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ThemeColor.actionPrimaryColor.color(context),
      surface: ThemeColor.surfacesBackground.color(context),
    ),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: ThemeColor.surfacesBackground.color(context),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: ThemeColor.actionPrimaryColor.color(context),
      surface: ThemeColor.surfacesBackground.color(context),
    ),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: ThemeColor.surfacesBackground.color(context),
  );
}

