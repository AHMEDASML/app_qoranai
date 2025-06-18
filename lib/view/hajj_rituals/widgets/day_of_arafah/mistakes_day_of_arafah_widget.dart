import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MistakesDayOfArafahWidget extends StatelessWidget {
  const MistakesDayOfArafahWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'arafah_mistakes_title'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,),
              ),
              SizedBox(height: 10.h),
              Text(
                'arafah_mistake_intro'.tr,
                style: TextStyle(  fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(  fontSize:controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
                  children: [
                    const TextSpan(text: '1. '),
                    TextSpan(text: 'arafah_mistake_1'.tr),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(  fontSize:controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
                  children: [
                    const TextSpan(text: '2. '),
                    TextSpan(text: 'arafah_mistake_2'.tr),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(  fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
                  children: [
                    const TextSpan(text: '3. '),
                    TextSpan(text: 'arafah_mistake_3'.tr),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(  fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
                  children: [
                    const TextSpan(text: '4. '),
                    TextSpan(text: 'arafah_mistake_4'.tr),
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