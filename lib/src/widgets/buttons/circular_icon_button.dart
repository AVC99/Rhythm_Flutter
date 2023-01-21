import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Function()? onPressed;

  const CircularIconButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  }) : super(key: key);

  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? kLightBlack : kBrokenWhite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return IconButton(
          color: _getThemeColor(state.themeMode.name),
          icon: Icon(icon),
          tooltip: tooltip,
          onPressed: onPressed,
        );
      },
    );
  }
}
