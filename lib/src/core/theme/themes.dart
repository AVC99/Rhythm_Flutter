import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rhythm/src/core/resources/colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme: const ColorScheme(
          primary: kSkyBlue,
          onPrimary: Colors.white,
          secondary: kSkyBlue,
          onSecondary: Colors.white,
          tertiary: kViolet,
          onTertiary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: kMarineBlue,
          onBackground: Colors.white,
          surface: kBrokenWhite,
          onSurface: kGrey,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: const CardTheme(
          color: kBrokenWhite,
        ),
        fontFamily: 'Montserrat',
      );

  static ThemeData get darkTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: const ColorScheme(
          primary: kSkyBlue,
          onPrimary: Colors.white,
          secondary: kSkyBlue,
          onSecondary: Colors.white,
          tertiary: kViolet,
          onTertiary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: kMarineBlue,
          onBackground: Colors.white,
          surface: kBrokenWhite,
          onSurface: Colors.white,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: kMarineBlue,
        cardTheme: const CardTheme(
          color: kBrokenWhite,
        ),
        fontFamily: 'Montserrat',
      );
}
