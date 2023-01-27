import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:rhythm/src/core/extensions/file.dart';
import 'package:rhythm/src/core/resources/constants.dart';

class StorageRepository {
  late final Reference postsReference;
  late final Reference profileReference;

  StorageRepository(FirebaseStorage firebaseStorage)
      : postsReference = firebaseStorage.ref(kPostsStorageReference),
        profileReference = firebaseStorage.ref(kProfileStorageReference);

  Future<String> _uploadImage(
    Reference reference,
    File file,
    String saveAs,
  ) async {
    final imageRef = reference.child(saveAs);
    final uploadTask = imageRef.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => {});

    return await snapshot.ref.getDownloadURL();
  }

  Future<String> uploadPost(File file, String username) async {
    return await _uploadImage(
      postsReference,
      file,
      '${username}_${Timestamp.now()}.${file.extension}',
    );
  }

  Future<String> uploadProfileAvatar(File file, String username) async {
    return await _uploadImage(
      profileReference,
      file,
      '$username.${file.extension}',
    );
  }
}
