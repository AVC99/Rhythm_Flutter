part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInEmailChangedEvent extends SignInEvent {
  final String email;

  const SignInEmailChangedEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class SignInPasswordChangedEvent extends SignInEvent {
  final String password;

  const SignInPasswordChangedEvent({required this.password});

  @override
  List<Object> get props => [password];
}


class SignInButtonPressedEvent extends SignInEvent {
  const SignInButtonPressedEvent();
}