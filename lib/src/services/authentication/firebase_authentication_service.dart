import 'package:firebase_auth/firebase_auth.dart';

import 'package:rhythm/src/models/user_entity.dart';
import 'package:rhythm/src/services/authentication/authentication_service.dart';
import 'package:rhythm/src/services/authentication/firebase_authentication_error.dart';

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

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuthentication.sendPasswordResetEmail(email: email);
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
