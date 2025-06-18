import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MistakesComingToMinaWidget extends StatelessWidget {
   MistakesComingToMinaWidget({Key? key}) : super(key: key);
HajjRitualsController hajjController = Get.find<HajjRitualsController>();
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
                      text: 'tarwiyah_mistake_intro'.tr + '\n\n',
                      style: TextStyle(
                        fontSize: controller.fontSize.value+8.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: '1.  ',
                      // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    TextSpan(
                      text: 'tarwiyah_mistake_1'.tr + '\n\n',
                      // style: TextStyle(fontSize: 16.sp),
                    ),
                    TextSpan(
                      text: '2.  ',
                      // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    TextSpan(
                      text: 'tarwiyah_mistake_2'.tr + '\n\n',
                      // style: TextStyle(fontSize: 16.sp),
                    ),
                    TextSpan(
                      text: '3.  ',
                      // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    TextSpan(
                      text: 'tarwiyah_mistake_3'.tr + '\n',
                      // style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
          
          Visibility(
            visible: hajjController.selectedTabHajj.value==HajjEnum.tamtoa,
            child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: controller.fontSize.value+2.sp,
                      color: AppColors.black,
                      fontFamily: 'NotoKufiArabic',
                    ),
                    children: [
                     
                      TextSpan(
                        text: '4.  ',
                        // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: 'hajj_beliefs_1'.tr + '\n\n',
                        // style: TextStyle(fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: '5.  ',
                        // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: 'hajj_beliefs_2'.tr + '\n\n',
                        // style: TextStyle(fontSize: 16.sp),
                      ),
                      
                    ],
                  ),
                ),
          ),
          
            ],
          ),
        );
      }
    );
  }
}