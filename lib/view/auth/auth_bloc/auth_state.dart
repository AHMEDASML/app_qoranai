// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
enum AuthStatus { succ, init, fail, load }

enum ReSendCodStatus { succ, init, fail, load }

enum TimerStatus { timerInitial, timerRunInProgress, timerRunComplete }

class AuthState {
  final int secound;
  final TimerStatus timerStatus;
  final bool isUnVisibalFirstPassword;
  final bool isUnVisibalSecoundPassword;
  final AuthStatus authStatus;
  final String messageError;
  final String messageErrorResendCode;
  final bool isbuttonColor;
  final String radioValue;
  final bool isSelectedPhoneField;
  final bool isSelectedEmailField;
  final ReSendCodStatus reSendCodStatus;

  const AuthState(
      {this.isbuttonColor = false,
      this.isSelectedPhoneField = true,
      this.isSelectedEmailField = true,
      this.radioValue = "citizen",
      this.isUnVisibalFirstPassword = true,
      this.authStatus = AuthStatus.init,
      this.messageError = "",
      this.messageErrorResendCode = "",
      this.isUnVisibalSecoundPassword = true,
      this.secound = 59,
      this.timerStatus = TimerStatus.timerInitial,
      this.reSendCodStatus = ReSendCodStatus.init});

  AuthState copyWith(
      {bool? isUnVisibalFirstPassword,
      bool? isUnVisibalSecoundPassword,
      AuthStatus? authStatus,
      String? messageError,
      String? messageErrorResendCode,
      int? secound,
      TimerStatus? timerStatus,
      bool? isbuttonColor,
      String? radioValue,
      bool? isSelectedPhoneField,
      bool? isSelectedEmailField,
      ReSendCodStatus? reSendCodStatus}) {
    return AuthState(
      messageErrorResendCode: messageErrorResendCode??this.messageErrorResendCode,
      reSendCodStatus: reSendCodStatus ?? this.reSendCodStatus,
      isSelectedPhoneField: isSelectedPhoneField ?? this.isSelectedPhoneField,
      isSelectedEmailField: isSelectedEmailField ?? this.isSelectedEmailField,
      radioValue: radioValue ?? this.radioValue,
      isUnVisibalFirstPassword:
          isUnVisibalFirstPassword ?? this.isUnVisibalFirstPassword,
      isUnVisibalSecoundPassword:
          isUnVisibalSecoundPassword ?? this.isUnVisibalSecoundPassword,
      authStatus: authStatus ?? this.authStatus,
      messageError: messageError ?? this.messageError,
      secound: secound ?? this.secound,
      timerStatus: timerStatus ?? this.timerStatus,
      isbuttonColor: isbuttonColor ?? this.isbuttonColor,
    );
  }
}
