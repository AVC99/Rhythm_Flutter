import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rhythm/core/resources/colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        colorScheme: ColorScheme(
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
          surface: kTransparentGrey,
          onSurface: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: kBrokenWhite,
        cardTheme: CardTheme(
          color: kTransparentGrey,
        ),
        fontFamily: 'Montserrat',
      );

  static ThemeData get darkTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        colorScheme: ColorScheme(
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
          surface: kTransparentGrey,
          onSurface: Colors.white,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: kMarineBlue,
        cardTheme: CardTheme(
          color: kTransparentGrey,
        ),
        fontFamily: 'Montserrat',
      );
}
