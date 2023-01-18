import 'package:firebase_auth/firebase_auth.dart';

import 'package:rhythm/src/core/localization.dart';
import 'package:rhythm/src/models/user_entity.dart';
import 'package:rhythm/src/services/authentication/authentication_service.dart';

class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth _firebaseAuthentication;

  FirebaseAuthenticationService({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuthentication = firebaseAuth;

  @override
  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuthentication.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(_firebaseAuthentication.currentUser!);
    } on FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await _firebaseAuthentication.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  UserEntity _mapFirebaseUser(User? user) {
    if (user == null) {
      return UserEntity.empty();
    }

    final map = <String, dynamic>{
      'email': user.email ?? '',
      'emailVerified': user.emailVerified,
      'imageUrl': user.photoURL ?? '',
      'isAnonymous': user.isAnonymous,
      'age': 0,
      'phoneNumber': '',
      'address': '',
    };
    return UserEntity.fromJson(map);
  }

  String _determineError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return Localization().loc!.invalidEmailError;
      case 'user-disabled':
        return Localization().loc!.userDisabledError;
      case 'user-not-found':
        return Localization().loc!.userNotFoundError;
      case 'wrong-password':
        return Localization().loc!.wrongPasswordError;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return Localization().loc!.emailAlreadyInUseError;
      case 'invalid-credential':
        return Localization().loc!.invalidCredentialError;
      case 'operation-not-allowed':
        return Localization().loc!.operationNotAllowedError;
      case 'weak-password':
        return Localization().loc!.weakPasswordError;
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return Localization().loc!.error;
    }
  }
}
