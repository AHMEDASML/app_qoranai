import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/core/resources/text/text18.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/params/auth/confirm_email_params.dart';
import 'package:Al_Arqam/core/app/params/auth/confirm_password_code_param.dart';
import 'package:Al_Arqam/core/app/params/auth/resend_code_params.dart';
import 'package:Al_Arqam/core/app/params/auth/verfication_code_params.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text20.dart';
import 'package:Al_Arqam/core/resources/toast.dart';
import 'package:get/get.dart';

import '../../../core/app/general_widgets/custom_button.dart';
import '../../../core/resources/asset_manger.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/global_functions.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/resources/text/text16.dart';
import '../../../generated/l10n.dart';
import '../auth_bloc/auth_bloc.dart';
import '../widgets/cuetom_verfication_code_input.dart';

class VerficationCodeScreen extends StatefulWidget {
  final String? previousPage;
  final String? userEmail;
  final String? userPhone;
  final String? password;
  final String? userName;
  final String? idCard;
  final String? legalStatus;
  const VerficationCodeScreen(
      {super.key,
      this.previousPage,
      this.userEmail,
      this.userPhone,
      this.password,
      this.userName,
      this.idCard,
      this.legalStatus});

  @override
  State<VerficationCodeScreen> createState() => _VerficationCodeScreenState();
}

class _VerficationCodeScreenState extends State<VerficationCodeScreen> {
  late AuthBloc authBloc;
  String verificationCode = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.reSendCodStatus == ReSendCodStatus.succ) {
                String message = state.messageError ==
                        "Password reset Code has just sent to your email"
                    ? "لقد تم إرسال الرمز بنجاح"
                    : S.of(context).resendCodeSuccess;
                Toast.showText(text: message);
              } else if (state.reSendCodStatus == ReSendCodStatus.fail) {
                Toast.showText(text: state.messageErrorResendCode);
              }

              if (state.authStatus == AuthStatus.succ) {
                Toast.showText(text: S.of(context).verificationSuccess);

                Future.delayed(Duration(milliseconds: 2), () {
                  if (widget.previousPage == "confirm_email") {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutesPath.resetPasswordRoute);
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutesPath.loginRoute);
                  }
                });
              } else if (state.authStatus == AuthStatus.fail) {
                Toast.showText(text: state.messageError);
                setState(() {
                  verificationCode = "";
                });
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(height: 80.h),
                          Image.asset(
                            AppImages.logo,
                            height: 200.h,
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Text14(
                              text: 'spam_check_message'.tr,
                              isBold: true,
                              color: AppColors.textSecoundary,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 300.h,
                            padding: EdgeInsets.all(30.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: AppColors.whiteBackground),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text20(
                                  text: S.of(context).verificationTitle,
                                  color: AppColors.textSecoundary,
                                ),
                                Text12(
                                  text: widget.userEmail != "" ||
                                          widget.userEmail != null
                                      ? S.of(context).enterCodeEmail
                                      : S.of(context).enterCodePhone,
                                  color: AppColors.textSecoundary,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: CustomVerificationCode(
                                      length: 6,
                                      onCompleted: (value) {
                                        print(
                                            "🎯 Verification code updated: '$value'");
                                        setState(() {
                                          verificationCode = value;
                                        });
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: state.timerStatus ==
                                              TimerStatus.timerRunInProgress
                                          ? null
                                          : () {
                                              authBloc.add(StartTimer());
                                              widget.previousPage ==
                                                      "confirm_email"
                                                  ? authBloc
                                                      .add(ConfirmEmailEvent(
                                                      isverifyEmailSecreen:
                                                          false,
                                                      confirmEmailBody:
                                                          ConfirmEmailBody(
                                                        email: widget.userEmail,
                                                        mobile:
                                                            widget.userPhone,
                                                      ),
                                                    ))
                                                  : authBloc
                                                      .add(ResendCodeEvent(
                                                      resendCodeBody:
                                                          ResendCodeBody(
                                                        email:
                                                            widget.userEmail ??
                                                                "",
                                                        mobile:
                                                            widget.userPhone ??
                                                                "",
                                                      ),
                                                    ));
                                            },
                                      child: Text12(
                                        text: S.of(context).resendCode,
                                        color: state.timerStatus ==
                                                TimerStatus.timerRunInProgress
                                            ? AppColors.textSecoundary
                                            : AppColors.primary,
                                      ),
                                    ),
                                    Text12(
                                        text: state.secound < 10
                                            ? '00:0${state.secound}'
                                            : '00:${state.secound}')
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          // Login Button

                          CustomButton(
                            onPressed: () {
                              print("🚀 Confirm button pressed");
                              print(
                                  "📋 Current verification code: '$verificationCode'");
                              print(
                                  "📋 Code length: ${verificationCode.length}");

                              if (formKey.currentState!.validate()) {
                                if (verificationCode.isEmpty) {
                                  Toast.showText(
                                      text: "الرجاء إدخال رمز التحقق");
                                  return;
                                }

                                if (verificationCode.length < 6) {
                                  Toast.showText(
                                      text: S.of(context).completeCode);
                                  return;
                                }

                                // التأكد من أن الرمز يحتوي على أرقام فقط
                                if (!RegExp(r'^[0-9]{6}$')
                                    .hasMatch(verificationCode)) {
                                  Toast.showText(
                                      text:
                                          "رمز التحقق يجب أن يحتوي على 6 أرقام فقط");
                                  return;
                                }

                                print(
                                    "✅ Sending verification code: '$verificationCode'");

                                // حفظ البيانات
                                if (widget.userEmail != null &&
                                    widget.userEmail!.isNotEmpty) {
                                  GlobalFunctions.setEmail(widget.userEmail!);
                                }
                                GlobalFunctions.setVerifictionCode(
                                    verificationCode);

                                // إرسال الطلب
                                if (widget.previousPage == "confirm_email") {
                                  authBloc.add(ConfirmPasswordCode(
                                    confirmPasswordCodeBody:
                                        ConfirmPasswordCodeBody(
                                      passwordCode: verificationCode,
                                      email: widget.userEmail ?? "",
                                      mobile: widget.userPhone ?? "",
                                    ),
                                  ));
                                } else {
                                  authBloc.add(VerficationCodeEvent(
                                    verficationCodeParams:
                                        VerficationCodeParams(
                                      verificationCode: verificationCode,
                                      email: widget.userEmail ?? "",
                                      mobile: widget.userPhone ?? "",
                                    ),
                                  ));
                                }
                              }
                            },
                            width: 200,
                            height: 70,
                            backgroundColor: AppColors.primary,
                            borderRadius: 50,
                            child: state.authStatus == AuthStatus.load
                                ? GlobalFunctions.showLoading(AppColors.white)
                                : Text16(
                                    text: S.of(context).confirmButton,
                                    color: AppColors.white,
                                  ),
                          ),

                          const Spacer(flex: 2),
                          SizedBox(height: 70.h),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
