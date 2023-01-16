import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/core/theme/theme_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemePersistence _themeRepository;
  late StreamSubscription<RhythmThemeMode> _themeSubscription;
  static late bool _isDarkTheme;

  ThemeCubit({
    required ThemePersistence themeRepository,
  })  : _themeRepository = themeRepository,
        super(const ThemeState());

  void getCurrentTheme() {
    _themeSubscription = _themeRepository.getTheme().listen(
          (customTheme) {
        if (customTheme.name == RhythmThemeMode.light.name) {
          _isDarkTheme = false;
          emit(state.copyWith(themeMode: ThemeMode.light));
        } else {
          _isDarkTheme = true;
          emit(state.copyWith(themeMode: ThemeMode.dark));
        }
      },
    );
  }

  void switchTheme() {
    if (_isDarkTheme) {
      _themeRepository.saveTheme(RhythmThemeMode.light);
    } else {
      _themeRepository.saveTheme(RhythmThemeMode.dark);
    }
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    _themeRepository.dispose();
    return super.close();
  }
}