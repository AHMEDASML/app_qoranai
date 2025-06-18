import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextTwaffAlqdomWidget extends StatelessWidget {
   TextTwaffAlqdomWidget({Key? key}) : super(key: key);
  final HajjRitualsController hajjController = Get.put(HajjRitualsController());
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
                  children:[
           TextSpan(
                      text: '${'tawaf_alqdom_title'.tr}\n',
                      style: TextStyle(
                        fontSize:controller.fontSize.value+8.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ]
                  )),
              // Title
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
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [


                    
                    // Points
                    TextSpan(
                      text:hajjController.selectedTabHajj.value == HajjEnum.quran?'${'\n'+'hajj_recommendation_1'.tr}\n\n': '\n'+'tawaf_point_1'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_point_2'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_bismillah'.tr,
                      style: TextStyle(color: Colors.red[800]),
                    ),
                    TextSpan(
                      text: 'tawaf_point_2_end'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_point_3'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_point_4'.tr,
                    ),
                  ],
                ),
              ),
              Container(
                height: 200.h,
                width: 200.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/alqdom.jpeg"),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Second RichText for the second part
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: controller.fontSize.value+2.sp,
                    color: AppColors.black,
                    fontFamily: 'NotoKufiArabic',
                  ),
                  children: [
                    TextSpan(
                      text: 'tawaf_point_5'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_dua'.tr,
                      style: TextStyle(color: Colors.red[800]),
                    ),
                    TextSpan(
                      text: 'tawaf_point_6'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_point_7'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_point_8'.tr,
                    ),
                    TextSpan(
                      text: 'tawaf_point_9'.tr,
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