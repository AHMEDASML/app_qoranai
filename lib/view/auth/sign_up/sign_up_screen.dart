import 'package:Al_Arqam/core/app/general_widgets/custom_language_toggle.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_phone.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/params/auth/sign_up_params.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/auth/verfication_code/verfication_code_screen.dart';
import 'package:Al_Arqam/view/auth/widgets/custom_radio.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:Al_Arqam/generated/l10n.dart';

import '../../../core/app/general_widgets/custom_text_form.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/toast.dart';
import '../auth_bloc/auth_bloc.dart';
import '../widgets/custom_text_link.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthBloc authBloc;
  late TextEditingController populationNumberController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController fullNameController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    confirmPasswordController = TextEditingController();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    populationNumberController = TextEditingController();
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
                image: AssetImage(AppImages.background), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          resizeToAvoidBottomInset: true,
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authStatus == AuthStatus.succ) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VerficationCodeScreen(
                    previousPage: "sign_up",
                    userEmail: emailController.text.isEmpty
                        ? ""
                        : emailController.text,
                    userPhone: phoneController.text.isEmpty
                        ? ""
                        : phoneController.text,
                    legalStatus: state.radioValue,
                    password: passwordController.text.isEmpty
                        ? ""
                        : passwordController.text,
                    idCard: populationNumberController.text.isEmpty
                        ? ""
                        : populationNumberController.text,
                    userName: fullNameController.text.isEmpty
                        ? ""
                        : fullNameController.text,
                  ),
                ));
              }
              if (state.authStatus == AuthStatus.fail) {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60.h),
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
                        Image.asset(AppImages.logo, height: 150.h),
                        SizedBox(height: 45.h),
                        CustomTextField(
                          textInputType: TextInputType.emailAddress,
                          onTap: () {
                            authBloc.add(SelectedFieldValue(
                                value: emailController.text,
                                fieldType: "email"));
      
                            phoneController.clear();
                          },
                          onChanged: (value) {},
                          isSelctedField: state.isSelectedEmailField,
                          controller: emailController,
                          hintText: S.of(context).emailHint,
                          prefixIcon: Icon(
                            Iconsax.sms5,
                            size: 25.h,
                          ),
                          validator: (value) {
                            return state.isSelectedEmailField
                                ? GlobalFunctions.validateEmail(
                                    value, context)
                                : null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        Text14(
                          text: S.of(context).orText,
                          color: AppColors.textSecoundary,
                        ),
                        SizedBox(height: 10.h),
                        InputPhoneNumberWidget(
                        isEmail: state.isSelectedEmailField,
                          controller:phoneController,
                           onTap: () {
                           
                            authBloc.add(SelectedFieldValue(
                                value: phoneController.text,
                                fieldType: "phone"));
                            emailController.clear();
                          },
                        
                        isEnabled: state.isSelectedPhoneField,),
                        // CustomTextField(
                          
                        //   textInputType: TextInputType.phone,
                        //   isSelctedField: state.isSelectedPhoneField,
                       
                        //   controller: phoneController,
                        //   hintText: S.of(context).phoneHint,
                        //   prefixIcon: Icon(
                        //     Iconsax.call5,
                        //     size: 25.h,
                        //   ),
                        //   validator: (value) {
                        //     return state.isSelectedPhoneField
                        //         ? GlobalFunctions.validPhoneNumber(
                        //             value ?? "",
                        //             context,
                        //           )
                        //         : null;
                        //   },
                        // ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(
                            thickness: 0.5,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          textInputType: TextInputType.text,
                          controller: fullNameController,
                          hintText: S.of(context).fullNameHint,
                          prefixIcon: Icon(
                            Iconsax.profile_circle5,
                            size: 25.h,
                          ),
                          validator: (value) {
                            return GlobalFunctions.valid(
                                value ?? "", 3, 50, context);
                          },
                        ),
                        SizedBox(height: 16.h),
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
                        SizedBox(height: 20.h),

                        // edite  hideing legalStatus for apple
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text12(
                        //       text: S.of(context).legalStatus,
                        //       color: AppColors.textSecoundary,
                        //     ),
                        //     const Spacer(),
                        //     LegalStatusOption(
                        //
                        //         value: "citizen",
                        //         groupValue: state.radioValue,
                        //         onChanged: (value) {
                        //           authBloc.add(
                        //               ChangeRadioValue(value: value ?? ""));
                        //         },
                        //         label: S.of(context).citizen,
                        //         isSelected: state.radioValue == "citizen"),
                        //     LegalStatusOption(
                        //         value: "resident",
                        //         groupValue: state.radioValue,
                        //         onChanged: (value) {
                        //           authBloc.add(
                        //               ChangeRadioValue(value: value ?? ""));
                        //         },
                        //         label: S.of(context).resident,
                        //         isSelected: state.radioValue == "resident"),
                        //     LegalStatusOption(
                        //         value: "visitor",
                        //         groupValue: state.radioValue,
                        //         onChanged: (value) {
                        //           authBloc.add(
                        //               ChangeRadioValue(value: value ?? ""));
                        //         },
                        //         label: S.of(context).visitor,
                        //         isSelected: state.radioValue == "visitor"),
                        //   ],
                        // ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          textInputType: TextInputType.number,
                          controller: populationNumberController,
                          hintText: S.of(context).populationNumberHint+' ('+'optional'.tr+') ',
                          prefixIcon: Icon(
                            Iconsax.password_check5,
                            size: 25.h,
                          ),
                          inputFormatters: [
        LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.digitsOnly,
                NoLeadingZeroInputFormatter(),
      ],
                          validator: (value) {
        if (value == null || value.isEmpty) {
          return null;
        }
        
        
        if (value.length < 9 || value.length > 20) {
          return    "population_number_range_error".tr;
        }
        return null;
      },
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: 200.w,
                          height: 70.h,
                          child: ElevatedButton(
                              onPressed:state.authStatus == AuthStatus.load?(){}: () {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    Toast.showText(
                                        text: S
                                            .of(context)
                                            .passwordMismatchError);
                                  } else {
                                    authBloc.add(SignUpEvent(
                                      signUpBody: SignUpBody(
                                        legalStatus: state.radioValue,
                                        password: passwordController.text,
                                        idCard:
                                            populationNumberController.text,
                                        userName: fullNameController.text,
                                        email: emailController.text.isNotEmpty
                                            ? emailController.text
                                            : "",
                                        mobile:
                                            phoneController.text.isNotEmpty
                                                ? phoneController.text
                                                : "",
                                      ),
                                    ));
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 18.h),
                              ),
                              child: state.authStatus == AuthStatus.load
                                  ? GlobalFunctions.showLoading(
                                      AppColors.white)
                                  : Text14(
                                      text: S.of(context).Continue,
                                      color: AppColors.white,
                                    )),
                        ),
                        const SizedBox(height: 20),
                        CustomTextLink(
                          firstText: S.of(context).alreadyHaveAccount,
                          secondText: S.of(context).login,
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutesPath.loginRoute);
                          },
                        ),
                        const SizedBox(height: 20),
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
