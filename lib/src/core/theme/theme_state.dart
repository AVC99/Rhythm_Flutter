part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({
    this.themeMode = ThemeMode.light,
  });

  ThemeState copyWith({ThemeMode? themeMode}) => ThemeState(
    themeMode: themeMode ?? this.themeMode,
  );

  @override
  List<Object?> get props => [themeMode];

  bool get isDarkThemeMode => themeMode.name == ThemeMode.dark.name;
}