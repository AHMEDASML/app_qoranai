import 'package:Al_Arqam/view/auth/nesseccary_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_type.dart';
import 'package:Al_Arqam/core/enums/crowading_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/crowading/controller/crowading_controller.dart';

class CrowadingScreen extends StatefulWidget {
  const CrowadingScreen({super.key});

  @override
  State<CrowadingScreen> createState() => _CrowadingScreenState();
}

class _CrowadingScreenState extends State<CrowadingScreen> {
  final CrowadingController controller = Get.put(CrowadingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CrowadingController>(
      builder: (controller) {
        return !GlobalFunctions.isAuth()
            ? NesseccaryLoginScreen(namePage: 'necessary_login_message'.tr)
            : Scaffold(
                backgroundColor: AppColors.whiteBackground,
                appBar: CustomAppBar(
                  backgroundColor: AppColors.whiteBackground,
                  title: 'crowding_status'.tr,
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Column(
                    children: [
                      Container(height: 1.h, color: AppColors.greyVerfication),
                      SizedBox(height: 40.h),
                      Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.containerGrey,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTap(
                              width: 120.w,
                              color: controller.selectedTab.value == CrowadingTypes.tawaf
                                  ? AppColors.primary
                                  : AppColors.containerGrey,
                              text: 'tawaf'.tr,
                              textColor: controller.selectedTab.value == CrowadingTypes.tawaf
                                  ? AppColors.white
                                  : AppColors.textSecoundary,
                              onTap: () {
                                controller.changeTab(CrowadingTypes.tawaf);
                                controller.update();
                              },
                            ),
                            CustomTap(
                              width: 120.w,
                              color: controller.selectedTab.value == CrowadingTypes.saee
                                  ? AppColors.primary
                                  : AppColors.containerGrey,
                              text: 'saee'.tr,
                              textColor: controller.selectedTab.value == CrowadingTypes.saee
                                  ? AppColors.white
                                  : AppColors.textSecoundary,
                              onTap: () {
                                controller.changeTab(CrowadingTypes.saee);
                                controller.update();
                              },
                            ),
                            CustomTap(
                              width: 120.w,
                              color: controller.selectedTab.value == CrowadingTypes.jamarat
                                  ? AppColors.primary
                                  : AppColors.containerGrey,
                              text: 'jamarat'.tr,
                              textColor: controller.selectedTab.value == CrowadingTypes.jamarat
                                  ? AppColors.white
                                  : AppColors.textSecoundary,
                              onTap: () {
                                controller.changeTab(CrowadingTypes.jamarat);
                                controller.update();
                              },
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<CrowadingController>(
                        builder: (controller) {
                          return controller.isLoading.value
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 300.h),
                                  child: Center(child: GlobalFunctions.showLoading(AppColors.primary, size: 30.sp)),
                                )
                              : Column(
                                  children: [
                                    Visibility(
                                      visible: controller.selectedTab.value == CrowadingTypes.tawaf,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 40.h),
                                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.secoundaryBackground,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: List.generate(5, (index) {
                                            return Container(
                                              margin: EdgeInsets.only(bottom: 2.h),
                                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(controller.floorstwaf[index], style: TextStyle(fontSize: 16.sp)),
                                                      Text(index == 0
                                                          ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.surface))
                                                          : index == 1
                                                              ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.mezanen))
                                                              : index == 2
                                                                  ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.groundFloor))
                                                                  : index == 3
                                                                      ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.firstFloor))
                                                                      : controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.sahen)),
                                                      style: TextStyle(fontSize: 16.sp)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  controller.response.crowding != null
                                                      ? LinearProgressIndicator(
                                                          backgroundColor: Colors.grey.withOpacity(0.4),
                                                          borderRadius: BorderRadius.circular(25),
                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                            index == 0
                                                                ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.surface))
                                                                : index == 1
                                                                    ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.mezanen))
                                                                    : index == 2
                                                                        ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.groundFloor))
                                                                        : index == 3
                                                                            ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.firstFloor))
                                                                            : controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].tawaf.sahen)),
                                                          ),
                                                          minHeight: 40.h,
                                                          value: index == 0
                                                              ? controller.convertToNumber(controller.response.crowding![0].tawaf.surface)
                                                              : index == 1
                                                                  ? controller.convertToNumber(controller.response.crowding![0].tawaf.mezanen)
                                                                  : index == 2
                                                                      ? controller.convertToNumber(controller.response.crowding![0].tawaf.groundFloor)
                                                                      : index == 3
                                                                          ? controller.convertToNumber(controller.response.crowding![0].tawaf.firstFloor)
                                                                          : controller.convertToNumber(controller.response.crowding![0].tawaf.sahen),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.selectedTab.value == CrowadingTypes.saee,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 40.h),
                                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.secoundaryBackground,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: List.generate(5, (index) {
                                            return Container(
                                              margin: EdgeInsets.only(bottom: 2.h),
                                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(controller.floorsaae[index], style: TextStyle(fontSize: 16.sp)),
                                                      Text(index == 0
                                                          ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].saai.basement))
                                                          : index == 1
                                                              ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].saai.mezanen))
                                                              : index == 2
                                                                  ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].saai.groundFloor))
                                                                  : index == 3
                                                                      ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].saai.firstFloor))
                                                                      : controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].saai.sahen)),
                                                      style: TextStyle(fontSize: 16.sp)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  controller.response.crowding != null
                                                      ? LinearProgressIndicator(
                                                          backgroundColor: Colors.grey.withOpacity(0.4),
                                                          borderRadius: BorderRadius.circular(25),
                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                            index == 0
                                                                ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].saai.basement))
                                                                : index == 1
                                                                    ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].saai.mezanen))
                                                                    : index == 2
                                                                        ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].saai.groundFloor))
                                                                        : index == 3
                                                                            ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].saai.firstFloor))
                                                                            : controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].saai.sahen)),
                                                          ),
                                                          minHeight: 40.h,
                                                          value: index == 0
                                                              ? controller.convertToNumber(controller.response.crowding![0].saai.basement)
                                                              : index == 1
                                                                  ? controller.convertToNumber(controller.response.crowding![0].saai.mezanen)
                                                                  : index == 2
                                                                      ? controller.convertToNumber(controller.response.crowding![0].saai.groundFloor)
                                                                      : index == 3
                                                                          ? controller.convertToNumber(controller.response.crowding![0].saai.firstFloor)
                                                                          : controller.convertToNumber(controller.response.crowding![0].saai.sahen),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.selectedTab.value == CrowadingTypes.jamarat,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 40.h),
                                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.secoundaryBackground,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: List.generate(5, (index) {
                                            return Container(
                                              margin: EdgeInsets.only(bottom: 2.h),
                                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(controller.floorjamrat[index], style: TextStyle(fontSize: 16.sp)),
                                                      Text(index == 0
                                                          ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.groundFloor))
                                                          : index == 1
                                                              ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.firstFloor))
                                                              : index == 2
                                                                  ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.secondFloor))
                                                                  : index == 3
                                                                      ? controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.thirdFloor))
                                                                      : controller.selectLevelFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.fourthFloor)),
                                                      style: TextStyle(fontSize: 16.sp)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  controller.response.crowding != null
                                                      ? LinearProgressIndicator(
                                                          backgroundColor: Colors.grey.withOpacity(0.4),
                                                          borderRadius: BorderRadius.circular(25),
                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                            index == 0
                                                                ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.groundFloor))
                                                                : index == 1
                                                                    ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.firstFloor))
                                                                    : index == 2
                                                                        ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.secondFloor))
                                                                        : index == 3
                                                                            ? controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.thirdFloor))
                                                                            : controller.selectColorFromNumber(controller.intToNumber(controller.response.crowding![0].jamrat.fourthFloor)),
                                                          ),
                                                          minHeight: 40.h,
                                                          value: index == 0
                                                              ? controller.convertToNumber(controller.response.crowding![0].jamrat.groundFloor)
                                                              : index == 1
                                                                  ? controller.convertToNumber(controller.response.crowding![0].jamrat.firstFloor)
                                                                  : index == 2
                                                                      ? controller.convertToNumber(controller.response.crowding![0].jamrat.secondFloor)
                                                                      : index == 3
                                                                          ? controller.convertToNumber(controller.response.crowding![0].jamrat.thirdFloor)
                                                                          : controller.convertToNumber(controller.response.crowding![0].jamrat.fourthFloor),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}