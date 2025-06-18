import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DwaaTwaffAlqdomWidget extends StatelessWidget {
  const DwaaTwaffAlqdomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                    TextSpan(
                      text: 'dua_tawaf_intro'.tr,
                    ),
                    TextSpan(
                      text: 'verse_109'.tr,
                      style: TextStyle(color: Colors.red[800]), // Colored in red
                    ),
                    TextSpan(
                      text: '\n\n' + 'dua_tawaf_second'.tr,
                    ),
                    TextSpan(
                      text: 'verse_118'.tr,
                      style: TextStyle(color: Colors.red[800]), // Colored in red
                    ),
                    TextSpan(
                      text: '\n\n' + 'dua_tawaf_third'.tr,
                    ),
                    TextSpan(
                      text: 'verse_19'.tr,
                      style: TextStyle(color: Colors.red[800]), // Colored in red
                    ),
                    TextSpan(
                      text: '\n\n' + 'dua_tawaf_fourth'.tr,
                    ),
                    TextSpan(
                      text: 'sunnah_reference'.tr,
                      style: TextStyle(color: Colors.red[800]), // Colored in red
                    ),
                    TextSpan(
                      text: '\n\n' + 'dua_tawaf_fifth'.tr,
                    ),
                    TextSpan(
                      text: 'sunnah_reference_second'.tr,
                      style: TextStyle(color: Colors.red[800]), // Colored in red
                    ),
                    TextSpan(
                      text: '\n\n' + 'dua_tawaf_seventh'.tr,
                    ),
                    TextSpan(
                      text: 'sunnah_reference_second'.tr,
                      style: TextStyle(color: Colors.red[800]), // Colored in red
                    ),
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