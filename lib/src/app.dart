import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/theme/theme_repository.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/core/theme/themes.dart';
import 'package:rhythm/src/core/routes.dart';
import 'package:rhythm/src/views/onboarding/start_view.dart';
import 'package:rhythm/src/views/theme_changer_view.dart';

class RhythmApp extends StatelessWidget {
  final ThemeRepository themeRepository;

  const RhythmApp({
    super.key,
    required this.themeRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ThemeRepository>.value(
          value: themeRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(
              themeRepository: context.read<ThemeRepository>(),
            )..getCurrentTheme(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Rhythm',
              debugShowCheckedModeBanner: false,
              themeMode: themeState.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              initialRoute: StartView.route,
              // initialRoute: ThemeChangerView.route,
              routes: routes,
            );
          },
        ),
      ),
    );
  }
}
