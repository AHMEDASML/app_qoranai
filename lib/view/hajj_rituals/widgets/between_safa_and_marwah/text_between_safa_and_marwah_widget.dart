import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Assuming you're using GetX for localization

class TextBetweenSafaAndMarwahWidget extends StatelessWidget {
   TextBetweenSafaAndMarwahWidget({Key? key}) : super(key: key);
  HajjRitualsController hajjController = Get.find<HajjRitualsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            children: [
             
              // Replace with your image path
              // Steps
                SizedBox(height: 8.sp),
                RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                    TextSpan(text: '${'safa_marwah_title'.tr}\n\n', style: TextStyle( fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,)),
                    TextSpan(text:hajjController.selectedTabHajj.value == HajjEnum.person?
                     '${'safa_marwah_step_1'.tr}\n':
                     hajjController.selectedTabHajj.value == HajjEnum.quran?
                     '${'tawaf_umrah_step_2'.tr}\n':'${'tawaf_umrah_step_1'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_2'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_3'.tr}\n'),
                     TextSpan(
                      text: '${'safa_marwah_quran_verse'.tr}\n',
                      style: TextStyle(color: Colors.red),
                    ),
                    
                    ])),
                     SizedBox(height: 8.sp),
                 Image.asset("assets/images/safaa2.png"),
                  SizedBox(height: 8.sp),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                  
                   
                    TextSpan(text: '${'safa_marwah_step_4'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_5'.tr}\n'),
                    TextSpan(
                      text: '${'safa_marwah_dua'.tr}\n',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    TextSpan(text: '${'safa_marwah_step_6'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_7'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_8'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_9'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_10'.tr}\n'),
                    TextSpan(
                      text: '${'safa_marwah_step_11'.tr}\n',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(text: '${'safa_marwah_step_12'.tr}\n'),
                    TextSpan(
                      text: '${'safa_marwah_step_13'.tr}\n',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    TextSpan(text: '${'safa_marwah_step_14'.tr}\n'),
                    TextSpan(text: '${'safa_marwah_step_15'.tr}\n'),
                  ],
                ),
              ),
              SizedBox(height: 16.sp), // Spacing between texts and images
              Image.asset("assets/images/safaa1.png"), // Replace with your image path
              SizedBox(height: 16.sp), // Spacing between images and next text
             
           
            ],
          ),
        );
      }
    );
  }
}