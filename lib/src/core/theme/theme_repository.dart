import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rhythm/src/core/resources/constants.dart';

abstract class ThemePersistence {
  Stream<RhythmThemeMode> getTheme();

  Future<void> saveTheme(RhythmThemeMode theme);

  void dispose();
}

enum RhythmThemeMode { light, dark }

class ThemeRepository implements ThemePersistence {
  final SharedPreferences _sharedPreferences;
  final _controller = StreamController<RhythmThemeMode>();

  ThemeRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _init();
  }

  String? _getValue(String key) {
    try {
      return _sharedPreferences.getString(key);
    } catch (_) {
      return null;
    }
  }

  Future<void> _setValue(String key, String value) =>
      _sharedPreferences.setString(key, value);

  void _init() {
    final themeString = _getValue(kThemeModePersistenceKey);

    if (themeString != null) {
      if (themeString == RhythmThemeMode.light.name) {
        _controller.add(RhythmThemeMode.light);
      } else {
        _controller.add(RhythmThemeMode.dark);
      }
    } else {
      var brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;

      _controller
          .add(isDarkMode ? RhythmThemeMode.dark : RhythmThemeMode.light);
    }
  }

  @override
  Stream<RhythmThemeMode> getTheme() async* {
    yield* _controller.stream;
  }

  @override
  Future<void> saveTheme(RhythmThemeMode theme) {
    _controller.add(theme);
    return _setValue(kThemeModePersistenceKey, theme.name);
  }

  @override
  void dispose() => _controller.close();
}
