import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_delete_account.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_tile.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_update_profile.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/core/resources/text/text18.dart';
import 'package:Al_Arqam/view/auth/nesseccary_login_screen.dart';
import 'package:Al_Arqam/view/camping/my_camping/my_camping_view.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:Al_Arqam/view/my_account/controller/my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  MyAccountController controller = Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(
      builder: (controller) {
        return !GlobalFunctions.isAuth()
            ? NesseccaryLoginScreen(namePage: 'necessary_login'.tr)
            : PopScope(
               canPop: false,
            // ignore: deprecated_member_use
            onPopInvoked: (_) async {
        // Replace pushNamed with pushAndRemoveUntil
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
        // return false; // Prevent default pop behavior
      },
              child: Scaffold(
                  backgroundColor: AppColors.white,
                  appBar: CustomAppBar(
                    title: 'my_account'.tr,
                    hasBackButton: null,
                    backgroundColor: AppColors.white,
                    triling: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showCustomUpdateProfile(
                            context,
                            GlobalFunctions.getUsername(),
                            GlobalFunctions.getIdCode()==null?'': GlobalFunctions.getIdCode(),
                            GlobalFunctions.getLegalStatus());
                      },
                    ),
                  ),
                  body: Column(
                    children: [
                      Container(
                        height: 1.h,
                        color: AppColors.greyVerfication,
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.containerGrey,
                            borderRadius: BorderRadius.circular(25.r)),
                        padding: EdgeInsets.all(20.h),
                        margin:EdgeInsets.only(
                                                left: 16.w, right: 16.w, top: 15.h),
                        child: Row(
                          children: [
                            Container(
                              height: 100.h,
                              // width:80.w,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(25.r)),
                              padding: EdgeInsets.all(20.h),
                              child: Image.asset("assets/images/twaff.png"),
                            ),
                            SizedBox(width: 40.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text18(
                                  text: GlobalFunctions.getUsername().toString(),
                                  isBold: true,
                                ),
                                Text16(
                                  text: GlobalFunctions.getEmail().toString(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.containerGrey,
                            borderRadius: BorderRadius.circular(25.r)),
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        margin:EdgeInsets.only(
                                                left: 16.w, right: 16.w, top: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text14(
                                  text: 'legal_status'.tr,
                                  isBold: true,
                                ),
                                SizedBox(height: 15.h),
                                Text14(
                                 

                                  text: GlobalFunctions.getIdCode()==null?"${GlobalFunctions.getLegalStatus()}":"${GlobalFunctions.getLegalStatus()} - ${GlobalFunctions.getIdCode().toString()}",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const MyCampingView());
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                                                left: 16.w, right: 16.w, top: 15.h),
                          decoration: BoxDecoration(
                            color: AppColors.containerGrey,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomTile(
                            color: AppColors.containerGrey,
                            fontsize: 12.sp,
                            title: 'support_numbers'.tr,
                            isExpansion: false,
                            leading: Icon(
                              Icons.arrow_forward_ios,
                              size: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                                                left: 16.w, right: 16.w, top: 15.h),
                        child: CustomButton(
                          backgroundColor: AppColors.error,
                          onPressed: () {
                            controller.sendMessage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.alarm5,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 5.w),
                              Text14(
                                text: 'emergency'.tr,
                                isBold: true,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                                                left: 16.w, right: 16.w, top: 15.h),
                        child: CustomButton(
                          backgroundColor: AppColors.error,
                          borderColor: AppColors.error,
                          isFillColor: false,
                          onPressed: () {
                            showCustomDeleteAccount(context);
                          },
                          child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text14(
                                      text: 'delete_account'.tr,
                                      isBold: true,
                                      color: AppColors.error,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
            );
      },
    );
  }
}