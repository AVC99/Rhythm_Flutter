import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/models/rhythm_user.dart';
import 'package:rhythm/src/providers/authentication_provider.dart';
import 'package:rhythm/src/controllers/authentication/authentication_state.dart';
import 'package:rhythm/src/providers/users_provider.dart';
import 'package:rhythm/src/repositories/authentication/firebase_authentication_error.dart';

final authenticationControllerProvider =
    StateNotifierProvider<AuthenticationController, AuthenticationState>(
  (ref) => AuthenticationController(ref),
);

class AuthenticationController extends StateNotifier<AuthenticationState> {
  final Ref ref;

  AuthenticationController(this.ref)
      : super(const AuthenticationInitialState());

  void createUser(RhythmUser newUser) async {
    state = const AuthenticationLoadingState();

    try {
      await ref
          .read(authenticationRepositoryProvider)
          .createUserWithEmailAndPassword(
            email: newUser.email!,
            password: newUser.password!,
          );

      await ref.read(usersRepositoryProvider).addUser(newUser);

      state = const AuthenticationAccountCreatedState();
    } catch (e) {
      state = AuthenticationErrorState(e as FirebaseAuthenticationError);
    }
  }

  void signIn(String email, String password) async {
    state = const AuthenticationLoadingState();

    try {
      await ref
          .read(authenticationRepositoryProvider)
          .signInWithEmailAndPassword(email, password);

      state = const AuthenticationSuccessState();
    } catch (e) {
      state = AuthenticationErrorState(e as FirebaseAuthenticationError);
    }
  }

  void signOut() async {
    await ref.read(authenticationRepositoryProvider).signOut();
  }

  void resetPassword(String email) async {
    state = const AuthenticationLoadingState();

    try {
      await ref
          .read(authenticationRepositoryProvider)
          .resetPassword(email: email);

      state = const AuthenticationRecoveryEmailSentState();
    } catch (e) {
      state = AuthenticationErrorState(e as FirebaseAuthenticationError);
    }
  }
}
