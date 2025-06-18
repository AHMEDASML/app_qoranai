import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:Al_Arqam/controllers/auth/auth_controller.dart';
import 'package:Al_Arqam/core/app/params/auth/confirm_email_params.dart';
import 'package:Al_Arqam/core/app/params/auth/confirm_password_code_param.dart';
import 'package:Al_Arqam/core/app/params/auth/reset_password_params.dart';
import 'package:Al_Arqam/core/app/params/auth/verfication_code_params.dart';
import 'package:meta/meta.dart';

import '../../../core/app/params/auth/login_params.dart';
import '../../../core/app/params/auth/resend_code_params.dart';
import '../../../core/app/params/auth/sign_up_params.dart';
import '../../../core/resources/global_functions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authControllerImp = AuthControllerImp();

  AuthBloc() : super(const AuthState()) {
    on<ChangeVisibalityFirst>((event, emit) {
      emit(state.copyWith(
          isUnVisibalFirstPassword: event.isUnVisible,
          messageError: "",
          authStatus: AuthStatus.init));
    });
    on<ChangeVisibalitySecound>((event, emit) {
      emit(state.copyWith(
          isUnVisibalSecoundPassword: event.isUnVisible,
          messageError: "",
          authStatus: AuthStatus.init));
    });
    on<ChangeButtonColor>((event, emit) {
      emit(state.copyWith(
          isbuttonColor: event.isButtonColor, authStatus: AuthStatus.init));
    });
    on<ChangeRadioValue>(
      (event, emit) {
        emit(state.copyWith(
            radioValue: event.value,
            messageError: "",
            authStatus: AuthStatus.init));
      },
    );
    on<SelectedFieldValue>(
      (event, emit) {
        if (event.value == "" && event.fieldType == "email") {
          emit(state.copyWith(
              isSelectedEmailField: true,
              isSelectedPhoneField: false,
              authStatus: AuthStatus.init,
              messageError: ""));
        }
        if (event.value == "" && event.fieldType == "phone") {
          emit(state.copyWith(
              isSelectedEmailField: false,
              isSelectedPhoneField: true,
              authStatus: AuthStatus.init,
              messageError: ""));
        }
      },
    );
    on<ConfirmEmailEvent>(_confirmEmailEvent);
    on<ConfirmPasswordCode>(_confirmPasswordCode);
    on<LoginEvent>(_mapLoginEvent);
    on<SignUpEvent>(_mapSignUpEvent);
    on<VerficationCodeEvent>(_mapVerficationCodeEvent);
    on<ResetPasswordEvent>(_mapResetPasswordEvent);
    on<StartTimer>(_onStarted);
    on<ResendCodeEvent>(_onResendCode);
  }



  FutureOr<void> _mapVerficationCodeEvent(
      VerficationCodeEvent event, Emitter<AuthState> emit) async {
    print("🔄 Starting verification process...");
    print("📝 Verification code: ${event.verficationCodeParams.verificationCode}");
    print("📧 Email: ${event.verficationCodeParams.email}");
    print("📱 Mobile: ${event.verficationCodeParams.mobile}");

    emit(state.copyWith(authStatus: AuthStatus.load));

    try {
      var result = await _authControllerImp
          .verifyEmail(event.verficationCodeParams.getBody());

      result.fold(
              (failure) {
            print("❌ Verification failed: ${failure.message}");
            emit(state.copyWith(
                authStatus: AuthStatus.fail,
                messageError: failure.message
            ));

            // مسح البيانات المحفوظة في حالة الفشل
            GlobalFunctions.removeEmail();
            GlobalFunctions.removeVerfication();
          },
              (response) {
            print("✅ Verification successful");
            emit(state.copyWith(authStatus: AuthStatus.succ));
          }
      );
    } catch (e) {
      print("💥 Exception during verification: $e");
      emit(state.copyWith(
          authStatus: AuthStatus.fail,
          messageError: "حدث خطأ غير متوقع: $e"
      ));
    }
  }









  FutureOr<void> _onResendCode(
      ResendCodeEvent event, Emitter<AuthState> emit) async {
        print('[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
    emit(state.copyWith(
        reSendCodStatus: ReSendCodStatus.load, authStatus: AuthStatus.init));
    var result =
        await _authControllerImp.resendCode(event.resendCodeBody.getBody());
    result.fold(
        (failure) => emit(
              state.copyWith(
                  reSendCodStatus: ReSendCodStatus.fail,
                  authStatus: AuthStatus.init,
                  messageErrorResendCode: failure.message),
            ), (response) {
      return emit(
        state.copyWith(
            reSendCodStatus: ReSendCodStatus.succ, authStatus: AuthStatus.init),
      );
    });
  }

  FutureOr<void> _mapSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {



    emit(state.copyWith(authStatus: AuthStatus.load));
    var result = await _authControllerImp.signUp(event.signUpBody.getBody());
    result.fold(
        (failure) => emit(
              state.copyWith(
                  authStatus: AuthStatus.fail, messageError: failure.message),
            ), (response) {
      GlobalFunctions.setVerifictionCode(
          response.verificationCode.toString() ?? "");

      return emit(
        state.copyWith(
          authStatus: AuthStatus.succ,
        ),
      );
    });
  }

  FutureOr<void> _mapLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.load));
    var result = await _authControllerImp.login(event.loginBody.getBody());
    result.fold((failure) {
      emit(
        state.copyWith(
            authStatus: AuthStatus.fail, messageError: failure.message),
      );
      log("fail ${failure.message}");
    }, (response) {
      GlobalFunctions.setToken(response.token!);
      GlobalFunctions.setEmail(response.user!.email??'');
      GlobalFunctions.setIdCode(response.user!.idCard);
      GlobalFunctions.setUsername(response.user!.username!);
      GlobalFunctions.setLegalStatus(response.user!.legalStatus.toString());

      log("success ${response.message}");
      return emit(
        state.copyWith(
          authStatus: AuthStatus.succ,
        ),
      );
    });
  }

  FutureOr<void> _confirmEmailEvent(
      ConfirmEmailEvent event, Emitter<AuthState> emit) async {
    if (event.isverifyEmailSecreen == true) {
      emit(state.copyWith(
        authStatus: AuthStatus.load,
      ));
      var result = await _authControllerImp
          .forgetPassword(event.confirmEmailBody.getBody());
      result.fold(
          (failure) => emit(
                state.copyWith(
                    authStatus: AuthStatus.fail, messageError: failure.message),
              ), (response) {
        return emit(
          state.copyWith(
            authStatus: AuthStatus.succ,
            
            
          ),
        );
      });
    } else {
      emit(state.copyWith(
        reSendCodStatus: ReSendCodStatus.load,
      ));
      var result = await _authControllerImp
          .forgetPassword(event.confirmEmailBody.getBody());
      result.fold(
          (failure) => emit(
                state.copyWith(
                    reSendCodStatus: ReSendCodStatus.fail,
                    messageErrorResendCode: failure.message),
              ), (response) async {
        return emit(
          state.copyWith(
              reSendCodStatus: ReSendCodStatus.succ,
              messageError: response.message),
        );
      });
    }
  }

  FutureOr<void> _confirmPasswordCode(
      ConfirmPasswordCode event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.load));
    var result = await _authControllerImp
        .confirmPasswordCode(event.confirmPasswordCodeBody.getBody());
    result.fold(
        (failure) {emit(
              state.copyWith(
                  authStatus: AuthStatus.fail, messageError: failure.message),
            );
            GlobalFunctions.removeEmail();
              GlobalFunctions.removeVerfication();
            },
            
             (response) {
      return emit(
        state.copyWith(
          authStatus: AuthStatus.succ,
        ),
      );
    });
  }

  FutureOr<void> _mapResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.load));
    var result = await _authControllerImp
        .resetPassword(event.resetPasswordBody.getBody());
    result.fold(
        (failure){emit(
              state.copyWith(
                  authStatus: AuthStatus.fail, messageError: failure.message),
            );
             GlobalFunctions.removeEmail();
              GlobalFunctions.removeVerfication();
            
            }, (response) {
      return emit(
        state.copyWith(
          authStatus: AuthStatus.succ,
        ),
      );
    });
  }

  void _onStarted(StartTimer event, Emitter<AuthState> emit) async {
    int i = 60;
    do {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          i--;
        },
      );

      emit(state.copyWith(
          secound: i,
          timerStatus: TimerStatus.timerRunInProgress,
          authStatus: AuthStatus.init,
          reSendCodStatus: ReSendCodStatus.init));
      if (i == 0) {
        emit(state.copyWith(
            secound: 0,
            timerStatus: TimerStatus.timerRunComplete,
            authStatus: AuthStatus.init,
            reSendCodStatus: ReSendCodStatus.init));
      } else {
        emit(state.copyWith(
            secound: i,
            timerStatus: TimerStatus.timerRunInProgress,
            authStatus: AuthStatus.init,
            reSendCodStatus: ReSendCodStatus.init));
      }
    } while (i > 0);
  }
}
