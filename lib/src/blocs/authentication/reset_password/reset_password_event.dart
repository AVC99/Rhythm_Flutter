part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ResetPasswordEmailChangedEvent extends ResetPasswordEvent {
  final String email;

  const ResetPasswordEmailChangedEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPasswordButtonPressedEvent extends ResetPasswordEvent {
  const ResetPasswordButtonPressedEvent();
}
