import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum FirestoreQueryError {
  aborted,
  alreadyExists,
  cancelled,
  dataLoss,
  deadlineExceeded,
  failedPrecondition,
  internal,
  invalidArgument,
  notFound,
  outOfRange,
  permissionDenied,
  resourceExhausted,
  unauthenticated,
  unavailable,
  unimplemented,
  unknown,
}

class FirestoreQueryErrorHandler {
  static String determineError(
      BuildContext context, FirestoreQueryError error) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    switch (error) {
      case FirestoreQueryError.alreadyExists:
        return localizations.firestoreAlreadyExistsError;
      case FirestoreQueryError.notFound:
        return localizations.firestoreNotFoundError;
      case FirestoreQueryError.permissionDenied:
        return localizations.firestorePermissionDeniedError;
      case FirestoreQueryError.unauthenticated:
        return localizations.firestoreUnauthenticatedError;
      default:
        return localizations.error;
    }
  }

  static FirestoreQueryError determineErrorCode(
    FirebaseException exception,
  ) {
    switch (exception.code) {
      case 'already-exists':
        return FirestoreQueryError.alreadyExists;
      case 'not-found':
        return FirestoreQueryError.notFound;
      case 'permission-denied':
        return FirestoreQueryError.permissionDenied;
      case 'unauthenticated':
        return FirestoreQueryError.unauthenticated;
      default:
        return FirestoreQueryError.unknown;
    }
  }
}
