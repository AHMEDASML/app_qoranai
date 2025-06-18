import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProhibitionOfIhramScreen extends StatelessWidget {
   ProhibitionOfIhramScreen({super.key});
  MainController controller=Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
           backgroundColor:AppColors.white,
              appBar:  CustomAppBar(title:"prohibitions".tr,
                          backgroundColor: Colors.white,
                         
                          // backgroundColor: AppColors.whiteBackground,
                          triling:CustomTrailing(),
                          
                           ),
        
                           body:
                   Stack(
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
                       SingleChildScrollView(
                         child: Container(
                           color:Colors.white.withOpacity(0.9),
                           child: Padding(
                             padding:  EdgeInsets.all(20.w),
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                      '${'forbiddenActions'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+6.sp,color:AppColors.primary,fontWeight:FontWeight.bold ),         
                                         ),
                                           Text(
                                      '1. ${'hairRemoval'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                           Text(
                                      '2. ${'fragrance'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                           Text(
                                      '3. ${'coveringHead'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                           Text(
                                      '4. ${'wearingSewnClothes'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                           Text(
                                      '5. ${'pickupLuqta'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                           Text(
                                      '6. ${'marriage'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                           Text(
                                      '7. ${'womenClothing'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                          Text(
                                      '8. ${'hunting'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                           Text(
                                      '9. ${'cuttingTrees'.tr}\n',
                                      style: TextStyle(fontSize: controller.fontSize.value+2.sp),         
                                         ),
                                          Text(
                                             '${'permissible_for_muhrim'.tr}\n',
                                             style: TextStyle(
                                               fontSize: controller.fontSize.value + 6.sp,
                                               color:AppColors.primary, // Replace with AppColors.primary
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                           _buildItem(1, 'wearing_ring'.tr),
                                           _buildItem(2, 'wearing_watch'.tr),
                                           _buildItem(3, 'wearing_earphones'.tr),
                                           _buildItem(4, 'wearing_sandals'.tr),
                                           _buildItem(5, 'using_umbrella'.tr),
                                           _buildItem(6, 'wearing_glasses'.tr),
                                           _buildItem(7, 'wearing_belt'.tr),
                                           _buildItem(8, 'using_car_roof'.tr),
                                           _buildItem(9, 'washing_head_body'.tr),
                                           _buildItem(10, 'dressing_wounds'.tr),
                                           SizedBox(height: 16.h), // Space before the last item
                                           Text(
                                             'carrying_belongings'.tr,
                                             style: TextStyle(fontSize: controller.fontSize.value + 2.sp), // Adjusted font size
                                           ),
                                       
                               ],
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
        );
      }
    );
  }
 Widget _buildItem(int number, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        '$number. $text',
        style: TextStyle(fontSize:controller.fontSize.value + 2.sp,fontWeight:FontWeight.w600), // Adjusted font size
      ),
    );
  }
}

