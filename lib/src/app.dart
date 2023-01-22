import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/core/theme/theme_repository.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/core/theme/themes.dart';
import 'package:rhythm/src/core/routes.dart';
import 'package:rhythm/src/providers/authentication_provider.dart';
import 'package:rhythm/src/views/splash_view.dart';
import 'package:rhythm/src/views/onboarding/start_view.dart';
import 'package:rhythm/src/views/home/home_view.dart';

class RhythmApp extends ConsumerWidget {
  final ThemeRepository themeRepository;

  const RhythmApp({
    super.key,
    required this.themeRepository,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authenticationStateProvider);

    return RepositoryProvider<ThemeRepository>.value(
      value: themeRepository,
      child: BlocProvider<ThemeCubit>(
        create: (BuildContext context) => ThemeCubit(
          themeRepository: context.read<ThemeRepository>(),
        )..getCurrentTheme(),
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
              home: authenticationState.when(
                data: (user) => user != null ? const HomeView() : const StartView(),
                error: (error, stacktrace) => const StartView(),
                loading: () => const SplashView(),
              ),
              routes: routes,
            );
          },
        ),
      ),
    );
  }
}
