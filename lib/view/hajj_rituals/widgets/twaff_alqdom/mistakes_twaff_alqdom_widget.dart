import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MistakesTwaffAlqdomWidget extends StatelessWidget {
  const MistakesTwaffAlqdomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                    TextSpan(
                      text: 'tawaf_mistakes_title'.tr + '\n\n',
                      style: TextStyle(
                        fontSize:controller.fontSize.value+8.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    // Mistakes
                    TextSpan(text: 'mistake_1111'.tr+'\n\n'),
                    TextSpan(text: 'mistake_2222'.tr+'\n\n'),
                    TextSpan(text: 'mistake_3333'.tr+'\n\n'),
                    TextSpan(text: 'mistake_4444'.tr+'\n\n'),
                    TextSpan(text: 'mistake_5555'.tr+'\n\n'),
                    TextSpan(text: 'mistake_6666'.tr+'\n\n'),
                    TextSpan(
                      text: 'mistake_7777'.tr,
                      children: [
                        TextSpan(
                          text: 'dua'.tr+' ',
                          style: TextStyle(color: Colors.red[800]), // Highlighted text in red
                        ),
                          TextSpan(
                          text: 'mistake_8888'.tr+'\n\n',
                           // Highlighted text in red
                        ),
                      ],
                    ),
                    TextSpan(text: 'mistake_9999'.tr+'\n\n'),
                    TextSpan(text: 'mistake_10'.tr),
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