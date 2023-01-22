import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/providers/authentication_provider.dart';
import 'package:rhythm/src/controllers/authentication/authentication_state.dart';

final authenticationControllerProvider =
    StateNotifierProvider<AuthenticationController, AuthenticationState>((ref) {
  return AuthenticationController(ref);
});

class AuthenticationController extends StateNotifier<AuthenticationState> {
  final Ref ref;

  AuthenticationController(this.ref)
      : super(const AuthenticationInitialState());

  void createUser(String email, String password) async {
    state = const AuthenticationLoadingState();

    try {
      await ref
          .read(authenticationRepositoryProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      state = const AuthenticationAccountCreatedState();
    } catch (e) {
      state = AuthenticationErrorState(e.toString());
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
      state = AuthenticationErrorState(e.toString());
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
      state = AuthenticationErrorState(e.toString());
    }
  }
}
