import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTrailing extends StatelessWidget {
   CustomTrailing({super.key});
  MainController mainController=Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap:(){
            mainController.increaseFontSize();
            mainController.update();
          },
          child: Container(
            width: 35.w,
            height: 45.h,
              decoration: BoxDecoration(
                color: AppColors.primary, 
                borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(color:AppColors.primary)
            ),
           // You can change the color as needed
            alignment: Alignment.center,
            child: Text(
              '+A',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 10.w), // Space between the containers
        InkWell(
            onTap:(){
            mainController.decreaseFontSize();
            mainController.update();
          },
          child: Container(
            width: 35.w,
            height: 45.h,
            alignment: Alignment.center,
          // You can change the color as needed
            decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(color:AppColors.primary)
            ),
            child: Text(
              '-A',
              style: TextStyle(color:AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}