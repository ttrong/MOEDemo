part of 'login_form_bloc.dart';

@freezed
class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    required EmailAddress emailAddress,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _LoginFormState;

  factory LoginFormState.initial() => LoginFormState(
        emailAddress: EmailAddress(''),
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
