import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextStayInMuzdalifahWidget extends StatelessWidget {
  const TextStayInMuzdalifahWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',
              ),
              children: [
                // Muzdalifah Title
                TextSpan(
                  text: '${'stay_muzdalifah'.tr}\n\n',
                  style: TextStyle(
                    fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                // Content
                TextSpan(
                  text:'1. ${'muzdalifah_arafah_sunset'.tr}\n',
                ),
                TextSpan(
                  text:'2. ${'muzdalifah_maghrib_isha'.tr}\n',
                ),
                TextSpan(
                  text: '3. ${'muzdalifah_night_remembering'.tr}\n',
                ),
                TextSpan(
                  text:'4. ${'muzdalifah_sunnah_overnight'.tr}\n',
                ),
                TextSpan(
                  text:'5. ${'muzdalifah_women_departure'.tr}\n',
                ),
                TextSpan(
                  text:'6. ${'muzdalifah_fajr_standing'.tr}\n',
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}