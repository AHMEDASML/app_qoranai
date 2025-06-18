import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MistakesThrowingTheJamratWidget extends StatelessWidget {
  const MistakesThrowingTheJamratWidget({Key? key}) : super(key: key);

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
                '${'stoning_mistakes_title'.tr}\n',
               style: TextStyle(
                    fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
              ),
              // SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: AppColors.black),
                  children: [
                    const TextSpan(text: '1. '),
                    TextSpan(text: '${'stoning_mistake_1'.tr}\n\n'),
                    const TextSpan(text: '2. '),
                    TextSpan(text: '${'stoning_mistake_2'.tr}\n\n'),
                    const TextSpan(text: '3. '),
                    TextSpan(text: '${'stoning_mistake_3'.tr}\n\n'),
                    const TextSpan(text: '4. '),
                    TextSpan(text: '${'stoning_mistake_4'.tr}\n\n'),
                    const TextSpan(text: '5. '),
                    TextSpan(text: '${'stoning_mistake_5'.tr}\n\n'),
                    const TextSpan(text: '6. '),
                    TextSpan(text: '${'stoning_mistake_6'.tr}\n\n'),
                    const TextSpan(text: '7. '),
                    TextSpan(text: '${'stoning_mistake_7'.tr}\n\n'),
                    const TextSpan(text: '8. '),
                    TextSpan(text: '${'stoning_mistake_8'.tr}\n'),
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