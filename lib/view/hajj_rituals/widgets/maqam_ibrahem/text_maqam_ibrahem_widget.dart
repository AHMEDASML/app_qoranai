import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextMaqamIbrahemWidget extends StatelessWidget {
  const TextMaqamIbrahemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',
              ),
              children: [
                // Title
                TextSpan(
                  text: 'maqam_ibrahem'.tr + '\n\n',
                  style: TextStyle(
                    fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                // Instructions
                TextSpan(
                  text: 'if_you_complete_tawaf'.tr,
                ),
                TextSpan(
                  text: 'take_from_maqam_ibrahem'.tr,
                  style: TextStyle(color: Colors.red[800]),
                ),
                TextSpan(
                  text: '\n' + 'pray_two_rakats'.tr,
                ),
                TextSpan(
                  text: 'say_oh_kafirun'.tr ,
                  style: TextStyle(color: Colors.red[800]),
                ),
                TextSpan(
                  text: ' ' + 'and_in_the_other'.tr,
                ),
                TextSpan(
                  text: 'say_he_is_allah'.tr ,
                  style: TextStyle(color: Colors.red[800]),
                ),
                TextSpan(
                  text: ' ' + 'do_not_prolong'.tr,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}