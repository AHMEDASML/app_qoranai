import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/view/main_controller.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String? answer;
  final Widget? leading;
  final bool isExpansion;
  final double? fontsize;
  final Function()? onTap;
  Color? color;
   CustomTile(
      {super.key,
      required this.title,
      this.answer,
      this.leading,
      this.fontsize,
      this.color,
      this.isExpansion = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    // print(Get.find<MainController>().fontSize.value );
    return isExpansion
        ? ExpansionTile(
          key:Key(title),
          minTileHeight:50.h,
            collapsedBackgroundColor:AppColors.containerGrey,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ) ,
            backgroundColor: AppColors.secoundaryBackground,
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            title: Text(
  title,
  textAlign: TextAlign.start,
  style: TextStyle(
    fontWeight: FontWeight.bold, // Make it bold
    fontSize:Get.find<MainController>().fontSize.value, // Set font size
  ),
),
            leading: leading,
            enabled: answer != null ? true : false,
          
            //childrenPadding: EdgeInsets.symmetric(horizontal: 18.w),
            children: answer != null
                ? [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w,right:16.w,bottom:12.h),
                      child: Row(
                        children: [
                         Container(
                          width: 300.w,
                           child: Text(
                             answer!,
                             textAlign: TextAlign.start,
                             
                             style: TextStyle(color: AppColors.textSecoundary, fontSize:Get.find<MainController>().fontSize.value+1.sp, ),
                             softWrap: true, // Enables soft wrapping
                           ),
                         ),
                        ],
                      ),
                    ),
                  ]
                : [],
          )
        : InkWell(
         
          child: Container(
              //alignment: Alignment.center,
               height:60.h,
              decoration: BoxDecoration(
                  color:color?? AppColors.colorSplash,
                  borderRadius: BorderRadius.circular(25.r)),
              padding: EdgeInsets.only(right: 10.w,left:10.h),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[Text12(
                  text: title,
                  isBold: true,
                  textAlign: TextAlign.start,
                ),
                leading!
                ]
              ),
            ),
        );
  }
}
