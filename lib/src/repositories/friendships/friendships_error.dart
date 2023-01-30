import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FriendshipDataError {
  pending,
  alreadyFriends,
  justAccepted,
  cannotSelfAddAsFriend,
}

class FriendshipDataErrorHandler {
  static String determineError(
    BuildContext context,
    FriendshipDataError error,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    switch (error) {
      case FriendshipDataError.pending:
        return localizations.friendRequestPending;
      case FriendshipDataError.alreadyFriends:
        return localizations.friendRequestAlreadyFriends;
      case FriendshipDataError.justAccepted:
        return localizations.friendRequestAccepted;
      case FriendshipDataError.cannotSelfAddAsFriend:
        return localizations.friendRequestToYourselfError;
      default:
        return localizations.error;
    }
  }
}
