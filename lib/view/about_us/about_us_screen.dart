import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_webview.dart' show WepVewScreen;
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: 'about_us_title'.tr,
          hasBackButton: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  SizedBox(height: 3.h),
            // Logo
            Padding(
              padding:  EdgeInsets.only(top:20.h),
              child: Image.asset(
                AppImages.logo,
                height: 150.h,
              ),
            ),
            // SizedBox(height: 45.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              margin: EdgeInsets.all(15.h),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',color: Colors.black, fontSize: 14.sp),
                  children: <TextSpan>[
                    TextSpan(text: 'about_us_intro'.tr),
                    TextSpan(
                      text: 'company_name'.tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'about_us_description'.tr),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap:(){
                Get.to(WepVewScreen(url:"https://www.dash.alarqambh.com/privacy-policy",title: 'privacy_policy_title'.tr ,));
              },
              child: Padding(
                      padding:  EdgeInsets.all(30.h),
                      child: Text(
                        'privacy_policy_title'.tr,
                        style:  TextStyle(fontSize: 16.sp,decoration:
                TextDecoration.underline,),
                        textAlign: TextAlign.start,
              
                        textDirection: Directionality.of(context),
                      ),
                    ),
            ),
    
          ],
        ),
      ),
    );
  }
}