
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MistakesSlaughteringHadiWidget extends StatelessWidget {
  const MistakesSlaughteringHadiWidget({Key? key}) : super(key: key);

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
                'hadi_mistakes_title'.tr,
                style: TextStyle(fontSize: controller.fontSize.value+8.sp,color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: AppColors.black),
                  children: [
                    const TextSpan(text: '1. '),
                    TextSpan(text: '${'hadi_mistake_1'.tr}\n\n'),
                    const TextSpan(text: '2. '),
                    TextSpan(text: '${'hadi_mistake_2'.tr}\n\n'),
                    const TextSpan(text: '3. '),
                    TextSpan(text: '${'hadi_mistake_3'.tr}\n\n'),
                    const TextSpan(text: '4. '),
                    TextSpan(text: '${'hadi_mistake_4'.tr}\n\n'),
                    const TextSpan(text: '5. '),
                    TextSpan(text: '${'hadi_mistake_5'.tr}\n'),
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