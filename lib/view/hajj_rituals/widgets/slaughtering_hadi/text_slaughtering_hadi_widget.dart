import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextSlaughteringHadiWidget extends StatelessWidget {
  const TextSlaughteringHadiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: controller.fontSize.value+4.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoKufiArabic',
              ),
              children: [
                TextSpan(
                  text: 'hajj_mandatory_hadi'.tr,
                  
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}