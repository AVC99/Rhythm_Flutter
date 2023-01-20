import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rhythm/src/core/resources/constants.dart';
import 'package:rhythm/src/core/validations/validation.dart';

@immutable
abstract class FieldValidator {
  static String? regularValidator(BuildContext context, String? value) {
    if (!Validation.isFulfilled(value)) {
      return AppLocalizations.of(context)!.requiredFieldError;
    }

    return null;
  }

  static String? emailValidator(BuildContext context, String? value) {
    if (!Validation.isFulfilled(value)) {
      return AppLocalizations.of(context)!.requiredFieldError;
    }

    if (!Validation.isValidEmail(value!)) {
      return AppLocalizations.of(context)!.invalidEmailError;
    }

    return null;
  }

  static String? passwordValidator(BuildContext context, String? value) {
    if (!Validation.isFulfilled(value)) {
      return AppLocalizations.of(context)!.requiredFieldError;
    }

    if (!Validation.isValidPassword(value!)) {
      return AppLocalizations.of(context)!
          .passwordLengthError(kMinPasswordLength);
    }

    return null;
  }

  static String? repeatPasswordValidator(
    BuildContext context,
    String? value,
    String? repeatPassword,
  ) {
    if (!Validation.isFulfilled(value)) {
      return AppLocalizations.of(context)!.requiredFieldError;
    }

    if (!Validation.isValidPassword(value!)) {
      return AppLocalizations.of(context)!
          .passwordLengthError(kMinPasswordLength);
    }

    if (value != repeatPassword) {
      return AppLocalizations.of(context)!.passwordsDoNotMatchError;
    }

    return null;
  }

  static String? userAgeValidator(BuildContext context, String? value, String locale) {
    if (!Validation.isFulfilled(value)) {
      return AppLocalizations.of(context)!.requiredFieldError;
    }

    if (!Validation.isAdult(value, locale)) {
      return AppLocalizations.of(context)!.underAgeError(kMinUserAge);
    }

    return null;
  }
}
