import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum UserDataError {
  emailAlreadyExists,
  usernameAlreadyExists,
  multipleUsersWithSameEmail,
}

class UserDataErrorHandler {
  static String determineError(BuildContext context, UserDataError error) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    switch (error) {
      case UserDataError.emailAlreadyExists:
        return localizations.emailAlreadyInUseError;
      case UserDataError.usernameAlreadyExists:
      case UserDataError.multipleUsersWithSameEmail:
        return localizations.usernameAlreadyInUseError;
      default:
        return localizations.error;
    }
  }
}
