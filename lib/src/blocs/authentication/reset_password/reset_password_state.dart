part of 'reset_password_bloc.dart';

enum ResetPasswordStatus { typing, loading, success, failure }

@immutable
class ResetPasswordState extends Equatable {
  final ResetPasswordStatus status;
  final String message;
  final String email;

  const ResetPasswordState({
    this.status = ResetPasswordStatus.typing,
    this.message = '',
    this.email = '',
  });

  ResetPasswordState copyWith({
    String? email,
    ResetPasswordStatus? status,
    String? message,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        email,
      ];
}
