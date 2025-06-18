import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTawafIfadahWidget extends StatelessWidget {
  const TextTawafIfadahWidget({Key? key}) : super(key: key);

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
                'tawaf_ifadah'.tr,
                style: TextStyle( fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle( fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
                  children: [
                    TextSpan(text: '${'tawaf_ifadah_text'.tr}'),
                  ],
                ),
              ),

               Text(
                '\n'+'twaff_11'.tr+'\n',
                style: TextStyle( fontSize: controller.fontSize.value+2.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle( fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',),
                  children: [
                    TextSpan(text: '${'twaff_22'.tr}'+'\n'),
                     TextSpan(text: '${'twaff_33'.tr}',style: TextStyle(color: Colors.red[800]),),
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