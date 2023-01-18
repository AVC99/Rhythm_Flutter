part of 'sign_in_bloc.dart';

enum SignInStatus { typing, loading, success, failure }

@immutable
class SignInState extends Equatable {
  final SignInStatus status;
  final String message;
  final String email;
  final String password;

  const SignInState({
    this.status = SignInStatus.typing,
    this.message = '',
    this.email = '',
    this.password = '',
  });

  SignInState copyWith({
    String? email,
    String? password,
    SignInStatus? status,
    String? message,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        email,
        password,
      ];
}
