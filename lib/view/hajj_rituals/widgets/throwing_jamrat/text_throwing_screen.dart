import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextThrowingScreen extends StatelessWidget {
  const TextThrowingScreen({Key? key}) : super(key: key);

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
                'tashreeq_rituals'.tr,
                style: TextStyle(
                  fontSize: controller.fontSize.value+8.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
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
                    TextSpan(text: '1. ${'days_of_tashriq_title'.tr}\n\n'),
                    TextSpan(text: '2. ${'days_of_tashriq_text_1'.tr}\n\n'),
                    TextSpan(
                      text: ' ${'days_of_tashriq_reference'.tr}\n\n',
                      style: TextStyle(color: Colors.red[800]),
                    ),
                    TextSpan(text: '3. ${'days_of_tashriq_text_2'.tr}\n'),
                    
                    TextSpan(text: '\n\n4. ${'days_of_tashriq_text_3'.tr}\n\n'),
                    TextSpan(text: '5. ${'days_of_tashriq_text_4'.tr}\n\n'),
                    TextSpan(text: '6. ${'days_of_tashriq_text_5'.tr}\n\n'),
                    TextSpan(text: '${'guidance_title'.tr}\n\n', style: TextStyle(
                    fontSize: controller.fontSize.value+6.sp,
                    color: AppColors.primary,
                    fontFamily: 'NotoKufiArabic',
                    fontWeight: FontWeight.bold
                  ),),
                    TextSpan(text: '${'guidance_text_1'.tr}\n\n'),
                    TextSpan(text: '${'guidance_text_2'.tr}\n\n'),
                    TextSpan(text: '${'guidance_text_3'.tr}\n\n'),
                    TextSpan(text: '${'guidance_text_4'.tr}\n'),
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