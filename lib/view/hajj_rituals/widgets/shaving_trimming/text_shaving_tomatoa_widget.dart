import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/maqam_ibrahem/maqam_ibrahem_screen.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextShavingTomatoaWidget extends StatelessWidget {
  const TextShavingTomatoaWidget({Key? key}) : super(key: key);

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
                //  TextSpan(
                //   text:'hajj_hair_cut_title'.tr,
                //   style: TextStyle( fontSize: 20.sp,
                //   color: AppColors.primary,
                //   fontWeight: FontWeight.bold,
                //   fontFamily: 'NotoKufiArabic',),
                // ),
                TextSpan(
                  text:'${'hair_cut_step_1'.tr}\n\n',
                ),
                TextSpan(
                  text: '${'hair_cut_step_2'.tr}\n\n',
                ),
                TextSpan(
                  text: '${'hair_cut_step_3'.tr}\n\n',
                ),
                TextSpan(
                  text: '${'hair_cut_step_4'.tr}\n\n',
                ),
                TextSpan(
                  text:hajjController.selectedTabHajj.value == HajjEnum.umrah?'${'hair_cut_step_6'.tr}\n${'completed_umrah'.tr}': '${'hair_cut_step_5'.tr}\n',
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}