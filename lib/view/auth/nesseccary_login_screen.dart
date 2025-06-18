import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NesseccaryLoginScreen extends StatelessWidget {
  String namePage;
  // bool? isback;
   NesseccaryLoginScreen({super.key,required this.namePage,});

  @override
  Widget build(BuildContext context) {
    return PopScope(
       canPop: false,
            onPopInvoked: (_) async {
        // Replace pushNamed with pushAndRemoveUntil
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
        // return false; // Prevent default pop behavior
      },
      child: Scaffold(
         extendBodyBehindAppBar: true,
        backgroundColor: AppColors.quranColor1,
        // backgroundColor: Colors.transparent,
         appBar: CustomAppBar(title:'',
         onTap:(){
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
         },
          backgroundColor: AppColors.quranColor1,),
        body:Padding(
          padding:  EdgeInsets.all(30.w),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
            Image.asset('assets/images/twaff.png'),
             SizedBox(height:60.h,),
            Text16(text:"${"login_neccessary".tr}${namePage}.",color:AppColors.primary,),
            SizedBox(height:20.h,),
            Padding(
                                          padding:  EdgeInsets.symmetric(vertical:10.h,horizontal:40.w),
                                          child: CustomButton(
                                          height:90.h,
                                          onPressed: () {
                                            
          Navigator.of(context).pushNamed(AppRoutesPath.loginRoute);
                                            // controller.launchWhatsApp("+${guide.mobile!.prefix.toString().substring(1, 4)}${guide.mobile!.number}");
                                            
                                          },
                                          borderRadius: 20.r,
                                          backgroundColor: AppColors.primary,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              
                                              Text14(
                                                text:
                                                    "login_or_create_account".tr,
                                                color: AppColors.white,
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