import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/splash/bloc/splash_bloc.dart';

import '../../core/resources/asset_manger.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/routes_manager.dart';
import '../../injection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc splashBloc;
  late Size size;

  @override
  void initState() {
    splashBloc = serviceLocator<SplashBloc>()..add(CheckAuthEvent());

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    size = ScreenUtil.defaultSize;

    super.didChangeDependencies();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: splashBloc,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:200.w,
                  height: 200.h,
                  child: Image.asset(
                    AppImages.logoSplash,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GlobalFunctions.showLoading(AppColors.primary)
              ],
            ),
          );
        }, listener: (context, state) async {
       
          if (!GlobalFunctions.getFirstOnce()) {
          
            await Future.delayed(const Duration(seconds: 5));
            Navigator.of(context)
                .pushReplacementNamed(AppRoutesPath.introRoute);
                GlobalFunctions.setFirstOnce(true);
          }
         
            else{
            print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
            await Future.delayed(const Duration(seconds: 5));
            Navigator.of(context)
            .pushReplacementNamed(AppRoutesPath.mainRoute);
                }
          
        }),
      ),
    );
  }
}
