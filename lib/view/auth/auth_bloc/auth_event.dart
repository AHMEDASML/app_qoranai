part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class ChangeVisibalityFirst extends AuthEvent {
  final bool isUnVisible;

  ChangeVisibalityFirst({required this.isUnVisible});
}

class ChangeVisibalitySecound extends AuthEvent {
  final bool isUnVisible;

  ChangeVisibalitySecound({required this.isUnVisible});
}

class ChangeRadioValue extends AuthEvent {
  final String value;

  ChangeRadioValue({required this.value});
}

class SelectedFieldValue extends AuthEvent {
  final String value;
  final String fieldType;
  SelectedFieldValue({
    required this.value,
    required this.fieldType,
  });
}

class LoginEvent extends AuthEvent {
  final LoginBody loginBody;

  LoginEvent({required this.loginBody});
}

class SignUpEvent extends AuthEvent {
  final SignUpBody signUpBody;

  SignUpEvent({required this.signUpBody});
}

class ConfirmEmailEvent extends AuthEvent {
  final ConfirmEmailBody confirmEmailBody;
  final bool isverifyEmailSecreen;

  ConfirmEmailEvent( {required this.confirmEmailBody,required this.isverifyEmailSecreen,});
}

class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordBody resetPasswordBody;

  ResetPasswordEvent({required this.resetPasswordBody});
}

class VerficationCodeEvent extends AuthEvent {
  final VerficationCodeParams verficationCodeParams;

  VerficationCodeEvent({required this.verficationCodeParams});
}

class ChangeButtonColor extends AuthEvent {
  final bool isButtonColor;

  ChangeButtonColor({required this.isButtonColor});
}

class ResendCodeEvent extends AuthEvent {
  final ResendCodeBody resendCodeBody;

  ResendCodeEvent({required this.resendCodeBody});
}

class ConfirmPasswordCode extends AuthEvent {
  final ConfirmPasswordCodeBody confirmPasswordCodeBody;

  ConfirmPasswordCode({required this.confirmPasswordCodeBody});
}

class StartTimer extends AuthEvent {}
