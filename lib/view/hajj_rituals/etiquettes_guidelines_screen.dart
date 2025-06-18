import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EtiquettesGuidelinesScreen extends StatelessWidget {
   EtiquettesGuidelinesScreen({super.key});
 HajjRitualsController hajjController = Get.find<HajjRitualsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (hajjController) {
        return Scaffold(
            backgroundColor: AppColors.whiteBackground,
          appBar: CustomAppBar(
            backgroundColor: AppColors.whiteBackground,
            title:
              'etiquettes_guidelines'.tr,
           triling:CustomTrailing()
          ),
         
          body: Stack(
            children: [
              Container(
                              padding: EdgeInsetsDirectional.symmetric(vertical:40.h),
        decoration: const BoxDecoration(

          image: DecorationImage(
            image: AssetImage('assets/images/count.jpeg'),
             opacity: 0.8,
            fit: BoxFit.cover,
          ),
        ),
                          ),
              Container(
                   color:Colors.white.withOpacity(0.9),
                padding:  EdgeInsets.all(20.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                                      '${'travel_etiquettes'.tr}\n',
                                      style:  TextStyle(
                                       fontSize: hajjController.fontSize.value+8.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontFamily: 'NotoKufiArabic',
                                      ),
                                    ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            final key = 'travel_etiquette_${index + 1}';
                            return RichText(
                              // textDirection: TextDirection.rtl,
                              text: TextSpan(
                                  style:  TextStyle(
                                     fontSize: hajjController.fontSize.value+2.sp,
                                     color:AppColors.black,
                                // fontWeight: FontWeight.w600,
                                fontFamily: 'NotoKufiArabic',
                                    ),
              
                                // style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: '${index + 1}. ${key.tr}'+'\n',
                                    style:  TextStyle(
                                     fontSize: hajjController.fontSize.value+2.sp,
                                // fontWeight: FontWeight.w600,
                                fontFamily: 'NotoKufiArabic',
                                    ),
                                  ),
                                 
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          RichText(
                            
                            text: TextSpan(
                               style:  TextStyle(
                                     fontSize: hajjController.fontSize.value+2.sp,
                                     color:AppColors.black,
                                // fontWeight: FontWeight.w600,
                                fontFamily: 'NotoKufiArabic',
                                    ),
                              children: [
                                 TextSpan(
                                  text: '${'general_guidance_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+8.sp, fontWeight: FontWeight.bold,                       color: AppColors.primary,
              ),
                                ),
                                TextSpan(
                                  text: '${'first_title'.tr}\n\n',
                                   style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                ),
                                TextSpan(
                                  text: 'first_content'.tr,
                                  style: const TextStyle(),
                                ),
                                  TextSpan(
                                  text: '\n\n${'second_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: 'second_content'.tr,
                                  // style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                 TextSpan(
                                  text: '\n\n${'third_title'.tr}\n\n',
                                 style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                ),
                                TextSpan(
                                  text: 'third_content'.tr,
                                
                                ),
                                  TextSpan(
                                  text: '\n\n${'fourth_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: 'fourth_content'.tr,
                                  // style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                 TextSpan(
                                  text: '\n\n${'fifth_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: 'fifth_content'.tr,
                                  // style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                TextSpan(
                                  text:'\n\n${'sixth_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: 'sixth_content'.tr,
                                  // style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                 TextSpan(
                                  text: '\n\n${'seventh_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: 'seventh_content'.tr,
                                  // style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                 TextSpan(
                                  text: '\n\n${'eighth_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: 'eighth_content'.tr,
                                  // style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                 TextSpan(
                                  text: '\n\n${'ninth_title'.tr}\n\n',
                                  style: TextStyle(fontSize: hajjController.fontSize.value+4.sp, fontWeight: FontWeight.bold, color: AppColors.black),
                                
                                  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                TextSpan(
                                  text: 'ninth_content'.tr,
                                  // style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                 TextSpan(
                      text: '\n\n${'travel_day_title'.tr}\n\n',
                      style: TextStyle(fontSize: hajjController.fontSize.value+8.sp, fontWeight: FontWeight.bold, color:AppColors.primary),
                    ),
                    TextSpan(text: '${'travel_day_1'.tr}\n\n'),
                    TextSpan(text: '${'travel_day_2'.tr}\n\n'),
                    TextSpan(text: '${'travel_day_3'.tr}\n\n'),
                    TextSpan(text: '${'travel_day_4'.tr}\n\n'),
                    TextSpan(text: '${'travel_day_5'.tr}\n\n'),
                    TextSpan(text: '${'travel_day_6'.tr}\n\n'),
                    TextSpan(text: '${'travel_day_7'.tr}\n\n'),
                    TextSpan(text: '${'travel_day_8'.tr}\n\n'),
                    TextSpan(text: 'travel_day_9'.tr),
              
                              ],
                            ),
                          ),
                          
                         
                         
                          
                          
                          
                          
                         
                           
                          
                          const SizedBox(height: 20),
                                        
                          // Add more sections in the same way...
                        ],
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
