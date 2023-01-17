import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/theme/theme_cubit.dart';

class ThemeChangerView extends StatefulWidget {
  const ThemeChangerView({Key? key}) : super(key: key);

  @override
  State<ThemeChangerView> createState() => _ThemeChangerViewState();
}

class _ThemeChangerViewState extends State<ThemeChangerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<ThemeCubit>().switchTheme();
            },
            child: Icon(
              state.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          );
        },
      ),
    );
  }
}
