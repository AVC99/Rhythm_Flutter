import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/repositories/storage/storage_repository.dart';

final storageRepositoryProvider = Provider<StorageRepository>(
  (ref) => StorageRepository(FirebaseStorage.instance),
);
