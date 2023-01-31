import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/src/models/rhythm_user.dart';

import 'package:rhythm/src/repositories/users/users_repository.dart';

final usersRepositoryProvider = Provider<UsersRepository>(
  (ref) => UsersRepository(),
);

final authenticatedUserProvider = FutureProvider((ref) async {
  return await ref
      .read(usersRepositoryProvider)
      .getUserByEmail(FirebaseAuth.instance.currentUser!.email!)
      .then((value) {
    return RhythmUser.fromJson(value.first.data() as Map<String, dynamic>);
  });
});
