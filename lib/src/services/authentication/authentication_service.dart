import 'package:rhythm/src/models/user_entity.dart';

abstract class AuthenticationService {
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> resetPassword({
    required String email,
  });
}
