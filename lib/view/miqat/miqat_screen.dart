import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class MiqatScreen extends StatelessWidget {
  MainController controller=Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        print( 1 - (controller.fontSize.value - 12) * 0.1);
          print( controller.fontSize.value);
        return Scaffold(
            backgroundColor:AppColors.white,
          appBar:  CustomAppBar(title:"miqats".tr,
                      backgroundColor: Colors.white,
                     
                      // backgroundColor: AppColors.whiteBackground,
                      triling:CustomTrailing() ),
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
                padding:  EdgeInsets.all(20.sp),
                  color:Colors.white.withOpacity(0.9),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'description'.tr,
                        style: TextStyle(fontSize:   controller.fontSize.value+4.sp, fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                       SizedBox(height: 20.h),
                     Padding(
                             padding:  EdgeInsets.all(16.h),
                             child: GridView.builder(
                              shrinkWrap:true,
                              physics: const NeverScrollableScrollPhysics(),
                               gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 3 items in a row
                     childAspectRatio:
                     GlobalFunctions.getLangCode()=="en"?controller.fontSize.value==15?0.45.w: controller.fontSize.value==16?0.4.w: controller.fontSize.value==17?0.37.w: ((1 - (controller.fontSize.value - 12) * 0.1)-0.3).w:
                     controller.fontSize.value==17?0.5.w: ((1 - (controller.fontSize.value - 12) * 0.1)-0.02).w, // Adjust aspect ratio as needed
                      crossAxisSpacing: 10,
                                   
                      mainAxisSpacing: 10,
                               ),
                               itemCount: miqats.length,
                               itemBuilder: (context, index) {
                      final miqat = miqats[index];
                      return Container(
                        
                         padding:  EdgeInsets.all(3.sp),
                        decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 2), // Border color and width
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                                   ),
                        child: Padding(
                          padding:  EdgeInsets.all(3.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical:3.h,horizontal: 6.w),
                                child: Text(
                                  miqat.name.tr,
                                  style: TextStyle(fontSize: controller.fontSize.value+4.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                               SizedBox(height: 4.h),
                              Padding(
                                padding:  EdgeInsets.all(3.w),
                                child: Text(
                                  miqat.distance.tr,
                                  style: TextStyle(fontSize: controller.fontSize.value+1, color: AppColors.primary),
                                ),
                              ),
                               SizedBox(height: 2.h),
                              Expanded(
                                child: Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Text(
                                    style: TextStyle(fontSize: controller.fontSize.value-1, fontWeight: FontWeight.bold),
                                    miqat.description.tr,
                                    // fontSize: 12.sp,
                                    // overflow: TextOverflow.visible,
                                    // textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                               },
                             ),
                           ),
                      
                     
                       SizedBox(height: 10.h),
                       Text(
                        '${'obligation'.tr}\n\n${'hadith'.tr}\n\n${'mecca_residents'.tr}\n\n${'residents_below_miqats'.tr}',
                        style: TextStyle(fontSize: controller.fontSize.value+2.sp),
                        
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

class Miqat {
  final String name;
  final String description;
  final String distance;

  Miqat({required this.name, required this.description, required this.distance});
}

List<Miqat> miqats = [
  Miqat(
    name:"miqat_dhu_hulayfah",
    description: 'miqat_dhu_hulayfah_desc',
    distance: 'miqat_dhu_hulayfah_distance',
  ),
  Miqat(
    name: 'miqat_al_juhfah',
    description: 'miqat_al_juhfah_desc',
    distance: 'miqat_al_juhfah_distance',
  ),
  Miqat(
    name: 'miqat_qarn_al_manzil',
    description: 'miqat_qarn_al_manzil_desc',
    distance: 'miqat_qarn_al_manzil_distance',
  ),
  Miqat(
    name: 'miqat_yalamlam',
    description: 'miqat_yalamlam_desc',
    distance: 'miqat_yalamlam_distance',
  ),
  Miqat(
    name: 'miqat_dhat_irq',
    description: 'miqat_dhat_irq_desc',
    distance: 'miqat_dhat_irq_distance',
  ),
];