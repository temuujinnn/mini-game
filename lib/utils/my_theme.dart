import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData myTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  canvasColor: canvasColor,
  cardColor: cardColor,
  unselectedWidgetColor: unselectedWidgetColor,
  visualDensity: VisualDensity.compact,
  buttonTheme: const ButtonThemeData(
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
    buttonColor: buttonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.elliptical(2, 2),
        topRight: Radius.elliptical(2, 2),
        bottomLeft: Radius.elliptical(2, 2),
        bottomRight: Radius.elliptical(2, 2),
      ),
    ),
  ),
  colorScheme: const ColorScheme(
    primary: primaryColor,
    primaryContainer: primaryContainerColor,
    secondary: secondaryColor,
    secondaryContainer: secondaryContainerColor,
    surface: surfaceColor,
    background: backgroundColor,
    error: errorColor,
    onPrimary: onPrimaryColor,
    onSecondary: onSecondaryColor,
    onSurface: onSurfaceColor,
    onBackground: onBackgroundColor,
    onError: onErrorColor,
    brightness: Brightness.dark,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: errorColor,
    contentTextStyle: TextStyle(
      color: onErrorColor,
      fontSize: 16.0,
    ),
    actionTextColor: primaryColor,
  ),
  cardTheme: const CardTheme(
    color: secondaryContainerColor,
    shadowColor: onSecondaryColor,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.elliptical(2, 2),
        topRight: Radius.elliptical(2, 2),
        bottomLeft: Radius.elliptical(2, 2),
        bottomRight: Radius.elliptical(2, 2),
      ),
    ),
  ),
);
