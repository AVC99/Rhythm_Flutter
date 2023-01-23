import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FirebaseAuthenticationError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  accountExistsWithDifferentCredential,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  defaultError,
  tooManyRequests,
  noError
}

class FirebaseAuthenticationErrorHandler {
  static String determineError(
    BuildContext context,
    FirebaseAuthenticationError error,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    switch (error) {
      case FirebaseAuthenticationError.invalidEmail:
        return localizations.invalidEmailError;
      case FirebaseAuthenticationError.userDisabled:
        return localizations.userDisabledError;
      case FirebaseAuthenticationError.userNotFound:
        return localizations.userNotFoundError;
      case FirebaseAuthenticationError.wrongPassword:
        return localizations.wrongPasswordError;
      case FirebaseAuthenticationError.emailAlreadyInUse:
      case FirebaseAuthenticationError.accountExistsWithDifferentCredential:
        return localizations.emailAlreadyInUseError;
      case FirebaseAuthenticationError.invalidCredential:
        return localizations.invalidCredentialError;
      case FirebaseAuthenticationError.operationNotAllowed:
        return localizations.operationNotAllowedError;
      case FirebaseAuthenticationError.weakPassword:
        return localizations.weakPasswordError;
      case FirebaseAuthenticationError.tooManyRequests:
        return localizations.tooManyRequestsError;
      default:
        return localizations.error;
    }
  }
}
