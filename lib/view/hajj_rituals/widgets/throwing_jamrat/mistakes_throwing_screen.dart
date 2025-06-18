import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MistakesThrowingScreen extends StatelessWidget {
  const MistakesThrowingScreen({Key? key}) : super(key: key);

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
                'mistakes_in_mina_title'.tr,
                style: TextStyle( fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,),
              ),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  style: TextStyle( fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
                  children: [
                    TextSpan(text: '1. ${'mistakes_in_mina_text_1'.tr}\n\n'),
                    TextSpan(text: '2. ${'mistakes_in_mina_text_2'.tr}\n\n'),
                    TextSpan(text: '3. ${'mistakes_in_mina_text_3'.tr}\n\n'),
                    TextSpan(text: '4. ${'mistakes_in_mina_text_4'.tr}\n'),
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