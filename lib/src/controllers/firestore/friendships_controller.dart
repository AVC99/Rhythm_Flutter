import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/models/rhythm_friendship.dart';
import 'package:rhythm/src/controllers/firestore/users_controller.dart';
import 'package:rhythm/src/controllers/firestore/firestore_state.dart';
import 'package:rhythm/src/providers/friendships_provider.dart';
import 'package:rhythm/src/repositories/firestore_error.dart';
import 'package:rhythm/src/repositories/friendships/friendships_error.dart';

final friendshipsControllerProvider =
    StateNotifierProvider<FriendshipsController, FirestoreQueryState>(
  (ref) => FriendshipsController(ref),
);

class FriendshipsController extends StateNotifier<FirestoreQueryState> {
  final Ref ref;

  FriendshipsController(this.ref) : super(const FirestoreQueryInitialState());

  Future<void> sendFriendRequest(
    String senderUsername,
    String receiverUsername,
  ) async {
    state = const FirestoreQueryLoadingState();

    try {
      if (senderUsername == receiverUsername) {
        throw FriendshipDataError.cannotSelfAddAsFriend;
      }

      final friendshipSent = await ref
          .read(friendshipsRepositoryProvider)
          .getFriendship(senderUsername, receiverUsername);

      if (friendshipSent != null) {
        friendshipSent.isAccepted
            ? state = const FirestoreFriendshipsDataErrorState(
                FriendshipDataError.alreadyFriends,
              )
            : state = const FirestoreFriendshipsDataErrorState(
                FriendshipDataError.pending,
              );
      }

      if (state is FirestoreFriendshipsDataErrorState) return;

      final friendshipReceived = await ref
          .read(friendshipsRepositoryProvider)
          .getFriendship(receiverUsername, senderUsername);

      if (friendshipReceived != null) {
        ref
            .read(friendshipsRepositoryProvider)
            .acceptFriendRequest(receiverUsername, senderUsername);

        ref
            .read(usersControllerProvider.notifier)
            .addFriend(senderUsername, receiverUsername);
        ref
            .read(usersControllerProvider.notifier)
            .addFriend(receiverUsername, senderUsername);

        friendshipReceived.isAccepted
            ? state = const FirestoreFriendshipsDataErrorState(
                FriendshipDataError.alreadyFriends,
              )
            : state = const FirestoreFriendshipsDataErrorState(
                FriendshipDataError.justAccepted,
              );
      }

      if (state is FirestoreFriendshipsDataErrorState) return;

      final friendship = RhythmFriendship(
        sender: senderUsername,
        receiver: receiverUsername,
        creationDate: DateTime.now(),
      );

      await ref
          .read(friendshipsRepositoryProvider)
          .createFriendship(friendship);

      state = const FirestoreQuerySuccessState();
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );
    }
  }

  Future<void> deleteFriendship(String userA, String userB) async {
    state = const FirestoreQueryLoadingState();

    try {
      await ref
          .read(friendshipsRepositoryProvider)
          .deleteFriendRequest(userA, userB);
      await ref
          .read(friendshipsRepositoryProvider)
          .deleteFriendRequest(userB, userA);

      await ref
          .read(usersControllerProvider.notifier)
          .deleteFriend(userA, userB);
      await ref
          .read(usersControllerProvider.notifier)
          .deleteFriend(userB, userA);

      state = const FirestoreFriendshipsDataErrorState(
        FriendshipDataError.deletedFriendship,
      );
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );
    }
  }
}
