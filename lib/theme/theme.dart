// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/theme/color_scheme.dart';
import 'package:budget_maker_app/theme/text_scheme.dart';
import 'package:flutter/material.dart';

/// Thème de l'application
class ThemeProvider {
  /// Cpuleur du thème
  late final ThemeColors colors;

  /// Thème du texte
  late final TextStyles textStyles;

  /// Thème clair
  late final ThemeData light;

  /// Thème sombre
  late final ThemeData dark;

  /// Constructeur du thème de l'application
  ThemeProvider() {
    colors = ThemeColors();
    textStyles = TextStyles();
    light = ThemeData(
      colorScheme: colors.lightColorSheme,
      brightness: Brightness.light,
      textTheme: textStyles.textTheme,
      useMaterial3: true,
      elevatedButtonTheme: _elevatedButtonThemeData(Brightness.light),
    );
    dark = ThemeData(
      colorScheme: colors.darkColorSheme,
      brightness: Brightness.dark,
      textTheme: textStyles.textTheme,
      useMaterial3: true,
      elevatedButtonTheme: _elevatedButtonThemeData(Brightness.dark),
    );
  }

  /// Récupère le thème en fonction de la luminosité
  ThemeData getFrom(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return dark;
      case Brightness.light:
        return light;
      default:
        return light;
    }
  }

  /// Récupère le thème des couleurs en fonction de la luminosité
  ColorScheme getColorScheme(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return colors.darkColorSheme;
      case Brightness.light:
        return colors.lightColorSheme;
      default:
        return colors.lightColorSheme;
    }
  }

  /// Thème des boutons
  ElevatedButtonThemeData _elevatedButtonThemeData(Brightness brightness) {
    var currentColors = getColorScheme(brightness);
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            textStyles.labellarge.copyWith(color: currentColors.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: currentColors.primary,
      ),
    );
  }
}
