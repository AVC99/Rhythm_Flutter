import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rhythm/src/services/authentication/authentication_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationService _authenticationService;

  SignInBloc({
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(const SignInState()) {
    on<SignInEmailChangedEvent>(_handleSignInEmailChangedEvent);
    on<SignInPasswordChangedEvent>(_handleSignInPasswordChangedEvent);
    on<SignInButtonPressedEvent>(_handleSignInButtonPressedEvent);
  }

  Future<void> _handleSignInEmailChangedEvent(
    SignInEmailChangedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _handleSignInPasswordChangedEvent(
    SignInPasswordChangedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleSignInButtonPressedEvent(
    SignInButtonPressedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: SignInStatus.loading));

    try {
      await _authenticationService.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      emit(state.copyWith(status: SignInStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: SignInStatus.failure,
        ),
      );
    } finally {
      emit(state.copyWith(status: SignInStatus.typing));
    }
  }
}
