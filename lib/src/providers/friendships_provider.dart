import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/repositories/friendships/friendships_repository.dart';

final friendshipsRepositoryProvider = Provider<FriendshipsRepository>(
  (ref) => FriendshipsRepository(),
);
