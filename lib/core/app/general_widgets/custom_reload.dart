import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ErrorReloadWidget extends StatelessWidget {

  final VoidCallback onRetry;
  final IconData icon;
  final double iconSize;

  const ErrorReloadWidget({
    Key? key,
   
    required this.onRetry,

    this.icon = Icons.error_outline,
    this.iconSize = 80.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Text( 'error_message'.tr,style:TextStyle(color:AppColors.black,fontSize:14.sp,fontWeight:FontWeight.bold),),
            
             SizedBox(height: 20.h),
             CustomButton(
              width:GlobalFunctions.getLangCode()=="ar"? 200.w:158.w,
              height:80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
               Text( 'retry'.tr,style:TextStyle(color:AppColors.white,fontSize:16.sp),),
                    
                Icon(Icons.refresh,color:AppColors.white,),

             ],),
             backgroundColor:AppColors.primary,
             
              onPressed: onRetry,),
            // ElevatedButton.icon(
            //   onPressed: onRetry,
            //   icon: const Icon(Icons.refresh),
            //   label:  Text( 'retry'.tr),
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.white,
            //     backgroundColor: AppColors.primary,
            //   ),
            // ),
             SizedBox(height: 150.h),
          ],
        ),
      ),
    );
  }
}
