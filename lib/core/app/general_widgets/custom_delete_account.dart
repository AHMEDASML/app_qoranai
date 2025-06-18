import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_text_form.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/generated/l10n.dart';

import 'package:Al_Arqam/view/my_account/controller/my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomDeleteAccount extends StatefulWidget {
 

  const CustomDeleteAccount({
    super.key,

  });

  @override
  _CustomDeleteAccountState createState() => _CustomDeleteAccountState();
}

class _CustomDeleteAccountState extends State<CustomDeleteAccount> {
  TextEditingController password=TextEditingController();
  
MyAccountController controller = Get.find();
  @override
  void initState() {
    super.initState();
     controller.isLoadingDelete.value=false;
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: AlertDialog(
        backgroundColor: AppColors.white,
        contentPadding: EdgeInsets.only(top: 10.h),
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.only(right: 20.w, top: 20.h),
        iconPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        content: Container(
          height: 350.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
                            //  Text12(text: 'full_name'.tr),
               Text14(text: 'text_delete'.tr),
              SizedBox(height: 30.h),
              SizedBox(
                height: 60.h,
                child: CustomTextField(
                  textInputType: TextInputType.text,
                  controller: password,
                  hintText:S.of(context).passwordHint,
                  prefixIcon: Icon(
                    Iconsax.lock5,
                    size: 25.h,
                  ),
                  onChanged:(_){
                    setState(() {
                      
                    });
                  },
                 
                ),
              ),
              SizedBox(height: 15.h),
             
              GetBuilder<MyAccountController>(
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                    child: Opacity(
                      opacity: password.text.isEmpty?0.2:1,
                      child: CustomButton(
                        height: 90.h,
                        onPressed:password.text.isEmpty|| controller.isLoadingDelete.value?(){}: () {
                          controller.deleteAccount(context,password.text);
                          // controller.updateProfile(context, username!.text, idCode!.text, legalStatus!);
                        },
                        borderRadius: 20.r,
                        borderColor: AppColors.error,
                        isFillColor: false,
                        backgroundColor: AppColors.white,
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.isLoadingDelete.value
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10.h),
                                      child: Center(
                                        child: GlobalFunctions.showLoading(
                                            AppColors.error, size: 14.sp),
                                      ),
                                    ),
                                  )
                                :
                                  Text14(
                                    text: 'delete_account'.tr,
                                    color: AppColors.error,
                                    isBold: true,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: CustomButton(
                  height: 90.h,
                  onPressed: () {
                    Get.back();
                  },
                  borderRadius: 20.r,
                  borderColor: AppColors.primary,
                  isFillColor: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text14(
                        text: 'cancel'.tr,
                        color: AppColors.primary,
                        isBold: true,
                      ),
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

void showCustomDeleteAccount(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomDeleteAccount();
    },
  );
}