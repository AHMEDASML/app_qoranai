import 'package:Al_Arqam/core/app/general_widgets/custom_language_toggle.dart';
import 'package:Al_Arqam/core/app/params/auth/resend_code_params.dart';
import 'package:Al_Arqam/view/auth/verfication_code/verfication_code_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/params/auth/login_params.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/core/resources/toast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/app/general_widgets/custom_button.dart';
import '../../../core/app/general_widgets/custom_text_form.dart';
import '../../../core/resources/global_functions.dart';
import '../../../generated/l10n.dart';
import '../../../view/auth/auth_bloc/auth_bloc.dart';
import '../widgets/custom_text_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc authBloc;
  late TextEditingController emailOrPhoneController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userEmail;
  String? userPhone;
  @override
  void initState() {
    authBloc = AuthBloc();
    emailOrPhoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(vertical:40.h),
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
                Toast.showText(
                    text: S.of(context).loginSuccess); // استبدال النص
                Navigator.of(context).pushNamed(AppRoutesPath.mainRoute);
              } else if (state.authStatus == AuthStatus.fail) {
                if(state.messageError.contains('التحقق من حسابك')||state.messageError.contains('verify your account')){
                  authBloc
                                                      .add(ResendCodeEvent(
                                                      resendCodeBody:
                                                          ResendCodeBody(
                                                        email:isStringOrInt(emailOrPhoneController.text)?emailOrPhoneController.text:"",
                                                        mobile:!isStringOrInt(emailOrPhoneController.text)?emailOrPhoneController.text:"",
                                                      ),
                                                    ));
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VerficationCodeScreen(
                    previousPage: "sign_up",
                    userEmail:!isStringOrInt(emailOrPhoneController.text)?emailOrPhoneController.text:"",
                      
                    userPhone:isStringOrInt(emailOrPhoneController.text)?emailOrPhoneController.text:"",
                    legalStatus: state.radioValue,
                    password: '',
                    idCard: '',
                    userName: '',
                  ),
                ));
                }
                else {Toast.showText(text: state.messageError);}
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
                          SizedBox(height: 40.h),
                            Row(
mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                      SizedBox(
                        height:90.h,
                        child: AnimatedToggle(
                                             backgroundColor:AppColors.primary,
                                               values: [ 'Ar','En'],
                                             onToggleCallback: (value) {
                                               print(value);
                                               setState(() {
                                                 // _toggleValue = value;
                                               });}),)]),
                          // Logo
                          Image.asset(
                            AppImages.logo,
                            height: 150.h,
                          ),
                          SizedBox(height: 45.h),
                          // Email or Phone Input
                          CustomTextField(
                            textInputType: TextInputType.visiblePassword,
                            isSelctedField: state.isSelectedPhoneField,
                            onTap: () {
                              authBloc.add(SelectedFieldValue(
                                  value: emailOrPhoneController.text,
                                  fieldType: "phone"));
                            },
                            controller: emailOrPhoneController,
                            hintText: S
                                .of(context)
                                .emailOrPhoneValidation, // استبدال النص
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
                        
                        
                          SizedBox(height: 20.h),
                          // Password Input
                          CustomTextField(
                            textInputType: TextInputType.visiblePassword,
                            controller: passwordController,
                            hintText: S.of(context).passwordHint,
                            prefixIcon: Icon(
                              Iconsax.lock5,
                              size: 25.h,
                            ),
                            obscureText: state.isUnVisibalFirstPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isUnVisibalFirstPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.textSecoundary,
                              ),
                              onPressed: () {
                                authBloc.add(ChangeVisibalityFirst(
                                    isUnVisible:
                                        !state.isUnVisibalFirstPassword));
                              },
                            ),
                            validator: (value) {
                              return GlobalFunctions.validatePassword(
                                  value, context);
                            },
                          ),
                          SizedBox(height: 15.h),
                          // Forgot Password
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutesPath.confirmEmailRoute);
                              },
                              child: Text(
                                S.of(context).forgotPassword, // استبدال النص
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecoundary,
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.sp,
                                    fontFamily: "NotoKufiArabic"),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          // Login Button
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authBloc.add(
                                  LoginEvent(
                                    loginBody: LoginBody(
                                      email: !isStringOrInt(emailOrPhoneController.text.trim())?emailOrPhoneController.text.trim():null,
                                      mobile:isStringOrInt(emailOrPhoneController.text.trim())?
                                      emailOrPhoneController.text.trim().length==9?emailOrPhoneController.text.trim().substring(1):emailOrPhoneController.text.trim():"",
                                      password: passwordController.text,
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
                                    text: S.of(context).login, // استبدال النص
                                    color: AppColors.white,
                                  ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomTextLink(
                              firstText:
                                  S.of(context).noAccount, // استبدال النص
                              secondText:
                                  S.of(context).createAccount, // استبدال النص
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
 
bool isStringOrInt(String input) {
  // Check if the input can be parsed as an integer
  return int.tryParse(input) != null;
}
}
