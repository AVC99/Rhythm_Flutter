import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhythm/src/repositories/authentication/authentication_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepository(FirebaseAuth.instance),
);

final authenticationStateProvider = StreamProvider<User?>(
  (ref) => ref.read(authenticationRepositoryProvider).authenticationStateChange,
);
