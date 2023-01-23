import 'package:equatable/equatable.dart';
import 'package:rhythm/src/repositories/authentication/firebase_authentication_error.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();

  @override
  List<Object> get props => [];
}

class AuthenticationLoadingState extends AuthenticationState {
  const AuthenticationLoadingState();

  @override
  List<Object> get props => [];
}

class AuthenticationSuccessState extends AuthenticationState {
  const AuthenticationSuccessState();

  @override
  List<Object> get props => [];
}

class AuthenticationRecoveryEmailSentState extends AuthenticationState {
  const AuthenticationRecoveryEmailSentState();

  @override
  List<Object> get props => [];
}

class AuthenticationAccountCreatedState extends AuthenticationState {
  const AuthenticationAccountCreatedState();

  @override
  List<Object> get props => [];
}

class AuthenticationErrorState extends AuthenticationState {
  final FirebaseAuthenticationError error;

  const AuthenticationErrorState(this.error);

  @override
  List<Object> get props => [error];
}
