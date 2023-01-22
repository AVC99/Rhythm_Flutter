import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhythm/src/repositories/authentication/firebase_authentication_error.dart';

class AuthenticationRepository {
  final FirebaseAuth _authentication;

  const AuthenticationRepository(this._authentication);

  Stream<User?> get authenticationStateChange =>
      _authentication.idTokenChanges();

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authentication.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _authentication.currentUser;
    } on FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _authentication.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  Future<void> signOut() async {
    await _authentication.signOut();
  }

  FirebaseAuthenticationError _determineError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return FirebaseAuthenticationError.invalidEmail;
      case 'user-disabled':
        return FirebaseAuthenticationError.userDisabled;
      case 'user-not-found':
        return FirebaseAuthenticationError.userNotFound;
      case 'wrong-password':
        return FirebaseAuthenticationError.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return FirebaseAuthenticationError.emailAlreadyInUse;
      case 'invalid-credential':
        return FirebaseAuthenticationError.invalidCredential;
      case 'operation-not-allowed':
        return FirebaseAuthenticationError.operationNotAllowed;
      case 'weak-password':
        return FirebaseAuthenticationError.weakPassword;
      case 'too-many-requests':
        return FirebaseAuthenticationError.tooManyRequests;
      default:
        return FirebaseAuthenticationError.defaultError;
    }
  }
}
