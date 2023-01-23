import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/repositories/users/users_repository.dart';

final usersRepositoryProvider = Provider<UsersRepository>(
  (ref) => UsersRepository(),
);
