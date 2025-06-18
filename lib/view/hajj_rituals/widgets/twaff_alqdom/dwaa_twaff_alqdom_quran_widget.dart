import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DwaaTwaffAlqdomQuranWidget extends StatelessWidget {
  const DwaaTwaffAlqdomQuranWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                text: '\n\n${'dua_first_part'.tr}',
              ),
              TextSpan(
                text: '\n${'dua_reference_1'.tr}',
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text: '\n${'dua_second_part'.tr}',
              ),
              TextSpan(
                text: '\n${'dua_reference_2'.tr}',
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(
                text: '\n${'dua_final_part'.tr}',
              ),
            ],
          ),
        );
      }
    );
  }
}