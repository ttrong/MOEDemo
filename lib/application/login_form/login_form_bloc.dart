import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:moe_cfims/domain/auth/auth_failure.dart';
import 'package:moe_cfims/domain/auth/auth_value_objects.dart';
import 'package:moe_cfims/domain/auth/i_auth_facade.dart';

part 'login_form_bloc.freezed.dart';
part 'login_form_event.dart';
part 'login_form_state.dart';

/// LoginFormBloc manages the user's login flow
@injectable
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final IAuthFacade _authFacade;

  LoginFormBloc(this._authFacade) : super(LoginFormState.initial()) {
    on<LoginFormEvent>((event, emit) async {
      await event.map(
        emailChanged: (e) async {
          emit(
            state.copyWith(
              emailAddress: EmailAddress(e.email),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        loginPressed: (e) async {
          Either<AuthFailure, Unit>? failureOrSuccess;
          final isEmailValid = state.emailAddress.isValid();
          if (isEmailValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await _authFacade.login(emailAddress: state.emailAddress);
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
