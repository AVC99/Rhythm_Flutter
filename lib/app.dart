import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/core/theme/theme_repository.dart';
import 'package:rhythm/core/theme/theme_cubit.dart';
import 'package:rhythm/core/theme/themes.dart';
import 'package:rhythm/core/routes.dart';

class RhythmApp extends StatelessWidget {
  final ThemeRepository themeRepository;

  const RhythmApp({
    super.key,
    required this.themeRepository,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: themeRepository,
      child: BlocProvider<ThemeCubit>(
        create: (BuildContext context) => ThemeCubit(
          themeRepository: context.read<ThemeRepository>(),
        )..getCurrentTheme(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (BuildContext context, ThemeState state) {
            return MaterialApp(
              title: 'Rhythm',
              debugShowCheckedModeBanner: false,
              themeMode: state.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              initialRoute: '/theme',
              routes: routes,
            );
          },
        ),
      ),
    );
  }
}
