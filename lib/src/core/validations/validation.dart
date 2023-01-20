import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:rhythm/src/core/resources/constants.dart';

@immutable
abstract class Validation {
  static bool isFulfilled(String? value) {
    return value != null && value.isNotEmpty;
  }

  static bool isValidEmail(String email) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.isNotEmpty && password.length >= kMinPasswordLength;
  }

  static bool areSamePassword(String password, String repeatPassword) {
    return password == repeatPassword;
  }

  static bool isAdult(String? dateOfBirth, String locale) {
    DateTime birthDate = DateFormat.yMMMMd(locale).parse(dateOfBirth!);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > kMinUserAge ||
        yearDiff == kMinUserAge && monthDiff >= 0 && dayDiff >= 0;
  }
}
