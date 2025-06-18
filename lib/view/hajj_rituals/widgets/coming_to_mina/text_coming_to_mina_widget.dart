import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextComingToMinaWidget extends StatelessWidget {
   TextComingToMinaWidget({Key? key}) : super(key: key);
HajjRitualsController hajjController = Get.find<HajjRitualsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize:controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',
              ),
              children: [
                 TextSpan(
                  text: '${'arrival_mina'.tr}\n\n',
                  style: TextStyle(
                    fontSize:controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                hajjController.selectedTabHajj.value==HajjEnum.tamtoa?
        TextSpan(
                  text: '${'hajj_day_8'.tr}\n\n',
                  // style: TextStyle(
                  //   fontSize: 20.sp,
                  //   fontWeight: FontWeight.bold,
                  //   color: AppColors.primary,
                  // ),
                ):
                TextSpan(
                  text: '${'mina_day_8_intro'.tr}\n\n',
                  // style: TextStyle(
                  //   fontSize: 20.sp,
                  //   fontWeight: FontWeight.bold,
                  //   color: AppColors.primary,
                  // ),
                ),
                TextSpan(
                  text: '${'mina_day_8_travel'.tr}\n\n',
                ),
                TextSpan(
                  text: '${'mina_day_8_night'.tr}\n',
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}