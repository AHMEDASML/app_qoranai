import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTwaffTamtoaWidget extends StatelessWidget {
  const TextTwaffTamtoaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
           padding:  EdgeInsets.all(10.w),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                     TextSpan(
                        text:'tawaf_of_umrah'.tr + '\n',
                        style: TextStyle(
                          fontSize: controller.fontSize.value+8.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                   
                  ],
                ),
              ),
              Container(
                  height: 300.h,
                  width: 300.w,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/clothes1.jpg"),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                    
                    TextSpan(
                      text: '${'umrah_tawaf_step_1'.tr}\n',
                    ),
                    TextSpan(
                      text: '\n${'umrah_tawaf_step_2'.tr}\n',
                    ),
                    TextSpan(
                      text: '\n${'umrah_tawaf_step_3'.tr}\n',
                    ),
                    TextSpan(
                      text: '\n${'umrah_tawaf_step_4'.tr}\n',
                    ),
                    
                    
                  ],
                ),
              ),
               Container(
                height: 200.h,
                width: 200.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/alqdom.jpeg"),
                  ),
                ),
              ),
              SizedBox(height: 20.h), 
               RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                    
                    
                    TextSpan(
                      text: '\n${'umrah_tawaf_step_5'.tr}\n',
                    ),
                    TextSpan(
                      text: '\n${'umrah_tawaf_step_6'.tr}\n',
                    ),
                    TextSpan(
                      text: '\n${'umrah_tawaf_step_7'.tr}\n',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}