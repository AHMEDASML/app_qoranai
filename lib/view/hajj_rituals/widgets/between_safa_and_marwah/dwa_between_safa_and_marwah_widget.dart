import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DwaBetweenSafaAndMarwahWidget extends StatelessWidget {
  const DwaBetweenSafaAndMarwahWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildPrayerText(),
            ],
          ),
        );
      }
    );
  }

  Widget _buildPrayerText() {
    return GetBuilder<MainController>(
      builder: (controller) {
        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: controller.fontSize.value+2.sp,
              color: AppColors.black,
              fontFamily: 'NotoKufiArabic',
            ),
            children: [
              TextSpan(
                text: 'verse'.tr,
                style: TextStyle(color: Colors.red), // Verse colored red
              ),
              TextSpan(
                text: '${'dua1'.tr}\n\n${'dua2'.tr}\n\n${'dua3'.tr}\n\n${'dua4'.tr}\n\n${'dua5'.tr}\n\n${'dua6'.tr}',
              ),
            ],
          ),
        );
      }
    );
  }
}