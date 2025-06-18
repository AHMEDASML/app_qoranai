import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/core/resources/toast.dart';
import 'package:iconsax/iconsax.dart';
import '../../../generated/l10n.dart';

import '../../../core/app/general_widgets/custom_button.dart';
import '../../../core/app/general_widgets/custom_text_form.dart';
import '../../../core/app/params/auth/reset_password_params.dart';
import '../../../core/resources/global_functions.dart';
import '../../../view/auth/auth_bloc/auth_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late AuthBloc authBloc;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authBloc = AuthBloc();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
                Toast.showText(text: S.of(context).resetPasswordSuccess);
                Navigator.of(context).pushNamed(AppRoutesPath.mainRoute);
              } else if (state.authStatus == AuthStatus.fail) {
                Toast.showText(text: state.messageError);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
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
                          height: 200.h,
                        ),
                        SizedBox(height: 45.h),
                        // Password Input
                        CustomTextField(
                          textInputType: TextInputType.visiblePassword,
                          controller: passwordController,
                          hintText: S.of(context).newPasswordHint,
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
      
                        SizedBox(height: 16.h),
                        CustomTextField(
                          textInputType: TextInputType.visiblePassword,
                          controller: confirmPasswordController,
                          hintText: S.of(context).confirmPasswordHint,
                          prefixIcon: Icon(
                            Iconsax.lock5,
                            size: 25.h,
                          ),
                          obscureText: state.isUnVisibalSecoundPassword,
                          suffixIcon: IconButton(
                            color: AppColors.textSecoundary,
                            icon: Icon(
                              state.isUnVisibalSecoundPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textSecoundary,
                            ),
                            onPressed: () {
                              authBloc.add(ChangeVisibalitySecound(
                                  isUnVisible:
                                      !state.isUnVisibalSecoundPassword));
                            },
                          ),
                          validator: (value) {
                            return GlobalFunctions.validatePassword(
                                value, context);
                          },
                        ),
                        SizedBox(height: 30.h),
                        // Reset Password Button
                        CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                Toast.showText(
                                    text:
                                        S.of(context).passwordMismatchError);
                              } else {
                                authBloc.add(
                                  ResetPasswordEvent(
                                    resetPasswordBody: ResetPasswordBody(
                                        password: passwordController.text,
                                        passwordToken: ""),
                                  ),
                                );
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
                                  text: S.of(context).save,
                                  color: AppColors.white,
                                ),
                        ),
                      ],
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
