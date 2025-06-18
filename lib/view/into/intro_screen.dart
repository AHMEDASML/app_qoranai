import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_language_toggle.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:get/get.dart';


import '../../../core/app/general_widgets/custom_button.dart';
import '../../../core/app/general_widgets/custom_text_form.dart';
import '../../../core/resources/global_functions.dart';
import '../../../view/auth/auth_bloc/auth_bloc.dart';
import '../../generated/l10n.dart';
import '../auth/widgets/custom_text_link.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late AuthBloc authBloc;
  late TextEditingController emailOrPhoneController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                height: ScreenUtil().screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 90.h),
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
                                               });}),
                      )

                      ]
                    ),

                    // Logo
                    Image.asset(
                      AppImages.logo,
                      height: 200.h,
                    ),
                    SizedBox(height: 45.h),
                    // Email or Phone Input
      
                    const Spacer(),
                    Text16(
                      text: S.of(context).chooseUsagePreference,
                      isBold: true,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                          backgroundColor: AppColors.primary,
                          width: double.infinity,
                          child: Text16(
                            text: S.of(context).continueAsGuest,
                            isBold: true,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            GlobalFunctions.setShowOnBoarding();
                            GlobalFunctions.setVisitorAuth();
      
                            Navigator.of(context)
                                .pushNamed(AppRoutesPath.mainRoute);
                          }),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                          backgroundColor: AppColors.primary,
                          width: double.infinity,
                          child: Text16(
                            text: S.of(context).createAccount,
                            isBold: true,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            GlobalFunctions.setShowOnBoarding();
                            Navigator.of(context)
                                .pushNamed(AppRoutesPath.signUpRoute);
                          }),
                    ),
                    SizedBox(height: 70.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
