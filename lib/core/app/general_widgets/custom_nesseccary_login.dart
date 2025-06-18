import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/view/main_controller.dart';

class CustomNesseccaryLogin extends StatefulWidget {
  final double initialFontSize;
  final Function(double) onFontSizeChanged;

  const CustomNesseccaryLogin({
    super.key,
    required this.initialFontSize,
    required this.onFontSizeChanged,
  });

  @override
  _FontSizeDialogState createState() => _FontSizeDialogState();
}

class _FontSizeDialogState extends State<CustomNesseccaryLogin> {
  late double fontSize;

  @override
  void initState() {
    super.initState();
    fontSize = widget.initialFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:  20.w,vertical:5.h),
      child: AlertDialog(
        backgroundColor:AppColors.white ,
        contentPadding: EdgeInsets.only(top: 10.h),
         buttonPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
           titlePadding: EdgeInsets.only(right:20.w,top: 20.h),
            iconPadding: EdgeInsets.zero,
             actionsPadding: EdgeInsets.symmetric(horizontal:  10.w,vertical:5.h),
      
        content: Container(
          height: 280.h,
          padding: EdgeInsets.zero,
          margin:  EdgeInsets.symmetric(horizontal:  10.w,vertical:5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
               SizedBox(height: 15.h),
              Text(
                "necessary_login_popup".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp,fontWeight:FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Padding(
                                      padding:  EdgeInsets.symmetric(vertical:10.h,horizontal:12.w),
                                      child: CustomButton(
                                      height:90.h,
                                      onPressed: () {
                                           Navigator.of(context).pushNamed(AppRoutesPath.signUpRoute);
                                        // controller.launchWhatsApp("+${guide.mobile!.prefix.toString().substring(1, 4)}${guide.mobile!.number}");
                                        
                                      },
                                      borderRadius: 20.r,
                                      backgroundColor: AppColors.primary,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          
                                          Text14(
                                            text:
                                                "sign_up_button".tr,
                                            color: AppColors.white,
                                            isBold: true,
                                          ),
                                         
                                          // SizedBox(width: 10.w),
                                        ],
                                      ),
                                                                  ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(vertical:10.h,horizontal:12.w),
                                      child: CustomButton(
                                      height:90.h,
                                      onPressed: () {
                                          Navigator.of(context).pushNamed(AppRoutesPath.loginRoute);
                                        // controller.launchWhatsApp("+${guide.mobile!.prefix.toString().substring(1, 4)}${guide.mobile!.number}");
                                        
                                      },
                                      borderRadius: 20.r,
                                      borderColor: AppColors.primary,
                                      isFillColor:false ,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          
                                          Text14(
                                            text:
                                                "login_button".tr,
                                            color:  AppColors.primary,
                                            isBold: true,
                                          ),
                                         
                                          // SizedBox(width: 10.w),
                                        ],
                                      ),
                                                                  ),
                                    ),
            
            
            ],
          ),
        ),
        
      ),
    );
  }
}

void showCustomNesseccaryLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomNesseccaryLogin(
        initialFontSize: Get.find<MainController>().fontSize.value,
        onFontSizeChanged: (newFontSize) {
          // Update the font size in your app
          Get.find<MainController>().fontSize.value = newFontSize;
          Get.find<MainController>().update();
        },
      );
    },
  );
}