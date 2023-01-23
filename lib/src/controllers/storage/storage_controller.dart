import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/controllers/storage/storage_state.dart';
import 'package:rhythm/src/providers/storage_provider.dart';
import 'package:rhythm/src/repositories/firestore_error.dart';

final storageControllerProvider =
    StateNotifierProvider<StorageController, StorageState>(
  (ref) => StorageController(ref),
);

class StorageController extends StateNotifier<StorageState> {
  final Ref ref;

  StorageController(this.ref) : super(const StorageInitialState());

  Future<String?> uploadPost(File file, String username) async {
    state = const StorageLoadingState();

    try {
      final imageUrl =
          await ref.read(storageRepositoryProvider).uploadPost(file, username);

      state = const StorageSuccessState();

      return imageUrl;
    } on FirebaseException catch (e) {
      state =
          StorageErrorState(FirestoreQueryErrorHandler.determineErrorCode(e));
      return null;
    }
  }

  Future<String?> uploadProfileAvatar(File file, String username) async {
    state = const StorageLoadingState();

    try {
      final imageUrl =
          await ref.read(storageRepositoryProvider).uploadProfileAvatar(file, username);

      state = const StorageSuccessState();

      return imageUrl;
    } on FirebaseException catch (e) {
      state =
          StorageErrorState(FirestoreQueryErrorHandler.determineErrorCode(e));
      return null;
    }
  }
}
