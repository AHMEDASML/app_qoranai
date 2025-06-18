import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MistakesStayInMuzdalifahWidget extends StatelessWidget {
  const MistakesStayInMuzdalifahWidget({Key? key}) : super(key: key);

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
                '${'muzdalifah_mistakes_title'.tr}\n',
                style: TextStyle(fontSize: controller.fontSize.value+8.sp, fontWeight: FontWeight.bold,color: AppColors.primary),
              ),
              SizedBox(height: 10.h),
              Text(
                'muzdalifah_mistakes_intro'.tr,
                style: TextStyle(fontSize:controller.fontSize.value+4.sp),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '1. '),
                    TextSpan(text: '${'muzdalifah_mistake_1'.tr}'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '2. '),
                    TextSpan(text: '${'muzdalifah_mistake_2'.tr}'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '3. '),
                    TextSpan(text: '${'muzdalifah_mistake_3'.tr}'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize:controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '4. '),
                    TextSpan(text: '${'muzdalifah_mistake_4'.tr}'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '5. '),
                    TextSpan(text: '${'muzdalifah_mistake_5'.tr}'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '6. '),
                    TextSpan(text: '${'muzdalifah_mistake_6'.tr}'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize: controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '7. '),
                    TextSpan(text: '${'muzdalifah_mistake_7'.tr}'),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'NotoKufiArabic',fontSize:controller.fontSize.value+2.sp, color: Colors.black),
                  children: [
                    TextSpan(text: '8. '),
                    TextSpan(text: '${'muzdalifah_mistake_8'.tr}'),
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