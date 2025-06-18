import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MistaksIhramFromMiqatWidget extends StatelessWidget {
  const MistaksIhramFromMiqatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize:controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',
              ),
              children: [
                // Title
                TextSpan(
                  text: 'mistakes_ihram_title'.tr + '\n\n',
                  style: TextStyle(
                    fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontFamily: 'NotoKufiArabic',
                  ),
                ),
                // Mistakes
                TextSpan(
                  text: 'mistake_1'.tr,
                ),
                TextSpan(
                  text: 'mistake_2'.tr,
                ),
                TextSpan(
                  text: 'mistake_3'.tr,
                ),
                TextSpan(
                  text: 'mistake_4'.tr,
                ),
                TextSpan(
                  text: 'mistake_5'.tr,
                ),
                TextSpan(
                  text: 'mistake_6'.tr,
                ),
                TextSpan(
                  text: 'mistake_7'.tr,
                ),
                TextSpan(
                  text: 'mistake_8'.tr,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}