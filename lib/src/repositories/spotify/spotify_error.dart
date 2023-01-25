import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SpotifyError { unknown }

abstract class SpotifyErrorHandler {
  static SpotifyError determineErrorCode(Exception error) {
    return SpotifyError.unknown;
  }

  static String determineError(
    BuildContext context,
    SpotifyError error,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return localizations.error;
  }
}
