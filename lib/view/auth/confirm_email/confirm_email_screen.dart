import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/params/auth/login_params.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/core/resources/toast.dart';
import 'package:Al_Arqam/view/auth/verfication_code/verfication_code_screen.dart';
import 'package:Al_Arqam/generated/l10n.dart';
import 'package:get/get.dart';
import '../../../core/app/general_widgets/custom_button.dart';
import '../../../core/app/general_widgets/custom_text_form.dart';
import '../../../core/app/params/auth/confirm_email_params.dart';
import '../../../core/resources/global_functions.dart';
import '../../../view/auth/auth_bloc/auth_bloc.dart';
import '../widgets/custom_text_link.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({super.key});

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  late AuthBloc authBloc;
  late TextEditingController emailOrPhoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userEmail;
  String? userPhone;

  @override
  void initState() {
    authBloc = AuthBloc();
    emailOrPhoneController = TextEditingController();
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
              if (state.authStatus == AuthStatus.succ) {
                Toast.showText(text: "resendCode".tr);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VerficationCodeScreen(
                    previousPage: "confirm_email",
                    userEmail: userEmail,
                    userPhone: userPhone,
                  ),
                ));
              } else if (state.authStatus == AuthStatus.fail) {
                Toast.showText(text: state.messageError);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      height: ScreenUtil().screenHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 80.h),
                          // Logo
                          Image.asset(
                            AppImages.logo,
                            height: 150.h,
                          ),
                          SizedBox(height: 45.h),
                          // Email or Phone Input
                          CustomTextField(
                            controller: emailOrPhoneController,
                            hintText: S.of(context).emailOrPhoneHint,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).emailOrPhoneValidation;
                              }
    
                              if (RegExp(r'^[a-zA-Z]').hasMatch(value)) {
                                if (!RegExp(
                                        r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return S.of(context).invalidEmail;
                                }
                                userEmail = value;
                                userPhone = "";
                              } else if (RegExp(r'^\d').hasMatch(value)) {
                              if (!RegExp(r'^03\d{7}$').hasMatch(value)&&!RegExp(r'^3\d{7}$').hasMatch(value)) {
                                  return "invalid_bahraini_phone".tr;
                                }
                                userPhone = value;
                                userEmail = "";
                              } else {
                                return "";
                              }
    
                              return null;
                            },
                            prefixIcon: null,
                          ),
                          SizedBox(height: 30.h),
                          // ConfirmEmail Button
                          CustomButton(
                            onPressed:state.authStatus == AuthStatus.load?(){}:() {
                              if (formKey.currentState!.validate()) {
                                authBloc.add(
                                  ConfirmEmailEvent(
                                    isverifyEmailSecreen: true,
                                    confirmEmailBody: ConfirmEmailBody(
                                      email: userEmail ?? "",
                                      mobile: userPhone ?? "",
                                    ),
                                  ),
                                );
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
                          const Spacer(),
                          // Aligning the "Create Account" link at the bottom
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomTextLink(
                              firstText: S.of(context).noAccount,
                              secondText: S.of(context).createAccount,
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutesPath.signUpRoute);
                              },
                            ),
                          ),
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
