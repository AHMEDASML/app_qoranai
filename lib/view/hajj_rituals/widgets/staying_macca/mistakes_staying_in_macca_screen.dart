import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MistakesStayingInMaccaScreen extends StatelessWidget {
  const MistakesStayingInMaccaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding:  EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${'staying_in_mecca_mistakes_title'.tr}",
                style: TextStyle(
                  fontSize: controller.fontSize.value+8.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              // SizedBox(height: 10.h),
              Text(
                'staying_in_mecca_mistake_1'.tr,
                style: TextStyle(
                  fontSize: controller.fontSize.value+2.sp,
                  color: AppColors.black,
                  fontFamily: 'NotoKufiArabic',
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}