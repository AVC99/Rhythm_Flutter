import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/theme/theme_cubit.dart';

class CustomQrCode extends StatelessWidget {
  final String data;
  final double size;

  const CustomQrCode({
    Key? key,
    required this.data,
    required this.size,
  }) : super(key: key);

  Color _getThemeColor(String mode) {
    return mode == ThemeMode.light.name ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return QrImage(
          data: data,
          foregroundColor: _getThemeColor(state.themeMode.name),
          size: size,
          semanticsLabel: AppLocalizations.of(context)!.qrSemanticLabel(data),
        );
      },
    );
  }
}
