
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextShavingTrimmingWidget extends StatelessWidget {
  const TextShavingTrimmingWidget({Key? key}) : super(key: key);

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
                'hajj_hair_cut_title'.tr,
                style: TextStyle( fontSize: controller.fontSize.value+8.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoKufiArabic',),
              ),
              SizedBox(height: 10.h),
              RichText(
                
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'NotoKufiArabic',
                    fontSize: controller.fontSize.value+2.sp, color: AppColors.black),
                  children: [
                    TextSpan(text: '${'hajj_hair_cut_text'.tr}'+'\n\n'),
                    // TextSpan(
                    //   text: ' ${'hajj_tawaf_reference'.tr}',
                     
                    // ),
                    TextSpan(text: ' (${ 'hajj_tawaf_reference_english'.tr})', style: TextStyle(color: Colors.red[800]),),
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