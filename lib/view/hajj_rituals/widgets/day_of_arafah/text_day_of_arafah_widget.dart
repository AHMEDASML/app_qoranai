import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextDayOfArafahWidget extends StatelessWidget {
  const TextDayOfArafahWidget({Key? key}) : super(key: key);

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
                'day_of_arafah'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,),
              ),
              SizedBox(height: 10.h),
              Text(
                '1- '+'arafah_day_9_travel'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',),
              ),
              SizedBox(height: 10.h),
              Text(
                '2- '+'arafah_standing_pillar'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',),
                  children: [
                    TextSpan(text:'3- '+ '${'arafah_best_day'.tr} '),
                    // TextSpan(
                    //   text: '${'arafah_hadith_highlight'.tr}',
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                '4- '+'arafah_numrah_sunnah'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: Colors.red[800]),
                  text: 'arafah_all_of_it_is_a_standing_place'.tr,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                '5- '+'arafah_exploit_time'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',),
              ),
              SizedBox(height: 10.h),
              Text(
                '6- '+'arafah_imam_speech'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',),
              ),
            ],
          ),
        );
      }
    );
  }
}