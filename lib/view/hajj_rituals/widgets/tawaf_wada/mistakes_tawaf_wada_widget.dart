import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MistakesTawafWadaWidget extends StatelessWidget {
  const MistakesTawafWadaWidget({Key? key}) : super(key: key);

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
                'farewell_tawaf_mistakes_title'.tr,
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
                    TextSpan(text: '${'mistake_111'.tr}\n\n'),
                    TextSpan(text: '${'mistake_222'.tr}\n\n'),
                    TextSpan(text: '${'mistake_333'.tr}\n\n'),
                    TextSpan(text: '${'mistake_444'.tr}\n\n'),
                    TextSpan(text: '${'mistake_555'.tr}\n'),
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