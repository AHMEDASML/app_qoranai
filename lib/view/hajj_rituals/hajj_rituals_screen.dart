import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_video.dart';
import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_tile.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/hajj_rituals/etiquettes_guidelines_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/individual_hajj_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/tamtao_hajj_screen.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HajjRitualsScreen extends StatefulWidget {
  const HajjRitualsScreen({super.key});

  @override
  State<HajjRitualsScreen> createState() => _HajjRitualsScreenState();
}

class _HajjRitualsScreenState extends State<HajjRitualsScreen> {
  final HajjRitualsController controller = Get.find<HajjRitualsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (mainController) {
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
            backgroundColor: AppColors.whiteBackground,
            appBar: CustomAppBar(
              title: 'hajj_rituals_title'.tr,
              onTap:(){
                  Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
              },
              backgroundColor: AppColors.whiteBackground,
              
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 1.h,
                    color: AppColors.greyVerfication,
                  ),
                  SizedBox(height: 20.h),
                   InkWell(
                       onTap: () {
                      // controller.changeTabHajj(HajjEnum.tamtoa);
                      Get.to(EtiquettesGuidelinesScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.secoundaryBackground,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CustomTile(
                        color: AppColors.containerGrey,
                        fontsize: 12.sp,
                        title: 'etiquettes_guidelines'.tr,
                        isExpansion: false,
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ),
                    SizedBox(height: 20.h),
                   Text14(
                    text: 'choose_hajj_type'.tr,
                    isBold: true,
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      controller.changeIndexManask(0);
                       controller.changeIndexManaskTamatoa(0);
                      controller.changeTabHajj(HajjEnum.person);
                      Get.to(IndividualHajjScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CustomTile(
                        color: AppColors.containerGrey,
                        fontsize: 12.sp,
                        
                        title: 'individual_hajj'.tr,
                        isExpansion: false,
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                     onTap: () {
                       controller.changeIndexManask(0);
                       controller.changeIndexManaskTamatoa(0);
                      controller.changeTabHajj(HajjEnum.quran);
                      Get.to(IndividualHajjScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CustomTile(
                        color: AppColors.containerGrey,
                        fontsize: 12.sp,
                        title: 'qiran_hajj'.tr,
                        isExpansion: false,
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                       onTap: () {
                         controller.changeIndexManask(0);
                       controller.changeIndexManaskTamatoa(0);
                      controller.changeTabHajj(HajjEnum.tamtoa);
                      Get.to(TamtaoHajjScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.secoundaryBackground,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CustomTile(
                        color: AppColors.containerGrey,
                        fontsize: 12.sp,
                        title: 'tamattu_hajj'.tr,
                        isExpansion: false,
                        leading: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                   Text14(
                    text: 'media'.tr,
                    isBold: true,
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap:(){
                      showHajjVideoDialog(context);
                    },
                    child: Image.asset("assets/images/video.png")),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}