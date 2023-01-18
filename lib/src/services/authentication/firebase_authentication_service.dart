import 'package:firebase_auth/firebase_auth.dart';

import 'package:rhythm/src/models/user_entity.dart';
import 'package:rhythm/src/services/authentication/authentication_service.dart';

enum FirebaseAuthError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  accountExistsWithDifferentCredential,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  defaultError,
  tooManyRequests,
  noError
}

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

  FirebaseAuthError _determineError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return FirebaseAuthError.invalidEmail;
      case 'user-disabled':
        return FirebaseAuthError.userDisabled;
      case 'user-not-found':
        return FirebaseAuthError.userNotFound;
      case 'wrong-password':
        return FirebaseAuthError.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return FirebaseAuthError.emailAlreadyInUse;
      case 'invalid-credential':
        return FirebaseAuthError.invalidCredential;
      case 'operation-not-allowed':
        return FirebaseAuthError.operationNotAllowed;
      case 'weak-password':
        return FirebaseAuthError.weakPassword;
      case 'too-many-requests':
        return FirebaseAuthError.tooManyRequests;
      default:
        return FirebaseAuthError.defaultError;
    }
  }
}
