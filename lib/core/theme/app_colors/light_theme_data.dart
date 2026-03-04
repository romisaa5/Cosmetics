import 'package:cosmetics/core/theme/app_colors/light_app_colors.dart';
import 'package:flutter/material.dart';
import '../app_texts/app_fonts.dart';

ThemeData getLightTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: LightAppColors.background,
    brightness: Brightness.light,
    fontFamily: AppFonts.cairo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: LightAppColors.primary800,
      brightness: Brightness.light,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: LightAppColors.grey900,
      displayColor: LightAppColors.grey900,
      fontFamily: AppFonts.cairo,
    ),
  );
}
