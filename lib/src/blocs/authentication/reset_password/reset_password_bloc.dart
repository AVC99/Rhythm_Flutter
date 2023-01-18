import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rhythm/src/services/authentication/authentication_service.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthenticationService _authenticationService;

  ResetPasswordBloc({
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(const ResetPasswordState()) {
    on<ResetPasswordEmailChangedEvent>(_handleResetPasswordEmailChangedEvent);
    on<ResetPasswordButtonPressedEvent>(_handleResetPasswordButtonPressedEvent);
  }

  Future<void> _handleResetPasswordEmailChangedEvent(
    ResetPasswordEmailChangedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        email: event.email,
        message: '',
      ),
    );
  }

  Future<void> _handleResetPasswordButtonPressedEvent(
    ResetPasswordButtonPressedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));

    try {
      await _authenticationService.resetPassword(
        email: state.email,
      );

      emit(state.copyWith(status: ResetPasswordStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: ResetPasswordStatus.failure,
        ),
      );
    } finally {
      emit(state.copyWith(status: ResetPasswordStatus.typing));
    }
  }
}
