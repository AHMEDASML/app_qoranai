import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IhramTextScreen extends StatelessWidget {
   IhramTextScreen({super.key});
 HajjRitualsController hajjController = Get.find<HajjRitualsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding:  EdgeInsets.all(10.w),
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
                    // Title
                    TextSpan(
                      text: '${'ihram_title'.tr}\n',
                      style: TextStyle(
                        fontSize: controller.fontSize.value+6.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontFamily: 'NotoKufiArabic',
                      ),
                    ),
                    // Before Ihram
                  
                  ],
                ),
              ),
               Container(
                height: 300.h,
                width: 300.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/clothes1.jpg"),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                   
                    // Before Ihram
                    TextSpan(
                      text: 'before_ihram'.tr,
                      style: TextStyle(
                        fontSize: controller.fontSize.value+6.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'NotoKufiArabic',
                      ),
                    ),
                    // Points
                    TextSpan(
                      text: '${'point_1'.tr}\n\n',
                    ),
                    TextSpan(
                      text: '${'point_2'.tr}\n\n',
                    ),
                    TextSpan(
                      text: '${'point_3'.tr}',
                        style: TextStyle(color: AppColors.black),
                    ),
                    TextSpan(
                      text:hajjController.selectedTabHajj.value == HajjEnum.person? 'labbayk'.tr:
                      
                      hajjController.selectedTabHajj.value == HajjEnum.quran?
                      'labbayk_2'.tr:
                      hajjController.selectedTabHajj.value == HajjEnum.umrah?
                      "labbayk_3".tr:
                      'labbayk_1'.tr,
                        style: TextStyle(color: AppColors.primary,fontWeight:FontWeight.bold,fontSize:18.sp),
                    ),
                    TextSpan(
                      text: '${'condition_start'.tr}',
                        style: TextStyle(color: AppColors.black),
                    ),
                    TextSpan(
                      text: '${'condition_blue'.tr}',
                        style: TextStyle(color:  AppColors.primary,fontWeight:FontWeight.bold,fontSize:18.sp),
                    ),
                    TextSpan(
                      text: '${'condition_end'.tr}',
                        style: TextStyle(color: AppColors.black),
                    ),
                    TextSpan(
                      text: '${'point_4'.tr}\n\n',
                    ),
                    TextSpan(
                      text: '${'point_5'.tr}\n\n',
                    ),
                    TextSpan(
                      text: '${'point_6'.tr}\n\n',
                    ),
                    TextSpan(
                      text: '${'point_7'.tr}\n',
                    ),
                    TextSpan(
                      text: 'talbiyah'.tr,
                      style: TextStyle(color: AppColors.primary),
                    ),
                    TextSpan(
                      text: 'women_say'.tr,
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