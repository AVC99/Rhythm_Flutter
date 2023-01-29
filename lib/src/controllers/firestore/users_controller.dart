import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/controllers/firestore/firestore_state.dart';
import 'package:rhythm/src/providers/users_provider.dart';
import 'package:rhythm/src/repositories/firestore_error.dart';
import 'package:rhythm/src/repositories/users/user_error.dart';

final usersControllerProvider =
    StateNotifierProvider<UsersController, FirestoreQueryState>(
  (ref) => UsersController(ref),
);

class UsersController extends StateNotifier<FirestoreQueryState> {
  final Ref ref;

  UsersController(this.ref) : super(const FirestoreQueryInitialState());

  Future<RhythmUser?> getUserByEmail(String email) async {
    state = const FirestoreQueryLoadingState();

    try {
      final List<DocumentSnapshot> results =
          await ref.read(usersRepositoryProvider).getUserByEmail(email);

      state = const FirestoreQuerySuccessState();

      if (results.isEmpty) {
        return null;
      } else if (results.length == 1) {
        return RhythmUser.fromJson(
          results.first.data() as Map<String, dynamic>,
        );
      } else {
        state = const FirestoreUsersDataErrorState(
          UserDataError.multipleUsersWithSameEmail,
        );

        return null;
      }
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );
      return null;
    }
  }

  Future<bool> existsEmail(String email) async {
    state = const FirestoreQueryLoadingState();

    try {
      final List<DocumentSnapshot> results =
          await ref.read(usersRepositoryProvider).getUserByEmail(email);

      state = const FirestoreQuerySuccessState();

      return results.isNotEmpty;
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );
      return true;
    }
  }

  Future<bool> existsUsername(String username) async {
    state = const FirestoreQueryLoadingState();

    try {
      final List<DocumentSnapshot> results =
          await ref.read(usersRepositoryProvider).getUserByUsername(username);

      state = const FirestoreQuerySuccessState();

      return results.isNotEmpty;
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );
      return true;
    }
  }

  Future<RhythmUser?> getAuthenticatedUser(String email) async {
    state = const FirestoreQueryLoadingState();

    try {
      final user = await getUserByEmail(email);

      state = const FirestoreQuerySuccessState();

      return user;
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );

      return null;
    }
  }

  Future<void> createUser(RhythmUser newUser) async {
    state = const FirestoreQueryLoadingState();

    try {
      await ref.read(usersRepositoryProvider).addUser(newUser);

      state = const FirestoreQuerySuccessState();
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );
    }
  }

  Future<void> updateUser(RhythmUser user) async {
    state = const FirestoreQueryLoadingState();

    try {
      await ref.read(usersRepositoryProvider).updateUser(user);

      state = const FirestoreQuerySuccessState();
    } on FirebaseException catch (e) {
      state = FirestoreQueryErrorState(
        FirestoreQueryErrorHandler.determineErrorCode(e),
      );
    }
  }
}
