import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTawafWadaWidget extends StatelessWidget {
  const TextTawafWadaWidget({Key? key}) : super(key: key);

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
                'tawaf_wada'.tr,
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
                     TextSpan(text: '1. ${'farewell_tawaf_title'.tr}\n\n'),
                     TextSpan(text: '2. ${'farewell_tawaf_text'.tr}'),
              TextSpan(
                text: '${'farewell_tawaf_command'.tr}\n\n',
                style: TextStyle(color: Colors.red[800]),
              ),
                    TextSpan(text: '3. ${'farewell_tawaf_text_2'.tr}\n\n'),
                    TextSpan(text: '4. ${'farewell_tawaf_text_3'.tr}\n'),
                    // TextSpan(text: '${'farewell_tawaf_text_4'.tr}\n'),
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