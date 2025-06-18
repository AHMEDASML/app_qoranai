import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TextStayingInMaccaScreen extends StatelessWidget {
   TextStayingInMaccaScreen({super.key});
HajjRitualsController hajjController = Get.find<HajjRitualsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
           padding:  EdgeInsets.all(16.w),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',
              ),
              children: [
                TextSpan(
                  text:"${'staying_in_mecca'.tr}\n\n",
                  style: TextStyle(fontSize:controller.fontSize.value+8.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      
                      ),
                ),
                TextSpan(
                  text: '${'arrival_info'.tr}\n',
                ),
          
                hajjController.selectedTabHajj.value==HajjEnum.tamtoa?
                TextSpan(text: ""):
                TextSpan(
                  text: 'keep_ahram'.tr+'\n',
                   style: TextStyle(color: Colors.red[800],fontWeight:FontWeight.bold,fontSize:18.sp), 
                ),
                 hajjController.selectedTabHajj.value==HajjEnum.tamtoa?
                TextSpan(text: ""):
                TextSpan(
                  text: '${'additional_info'.tr}\n',
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}