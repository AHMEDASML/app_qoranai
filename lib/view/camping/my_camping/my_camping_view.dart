import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_type.dart';
import 'package:Al_Arqam/core/enums/camping_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/auth/nesseccary_login_screen.dart';
import 'package:Al_Arqam/view/camping/controller/my_camping_controller.dart';
import 'package:Al_Arqam/view/camping/my_camping/widgets/details_guide_camping_widget.dart';
import 'package:Al_Arqam/view/camping/my_camping/widgets/details_program_camping_widget.dart';
import 'package:Al_Arqam/view/camping/my_camping/widgets/list_program_camping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyCampingView extends StatefulWidget {
  const MyCampingView({super.key});

  @override
  State<MyCampingView> createState() => _MyCampingViewState();
}

class _MyCampingViewState extends State<MyCampingView> {
  final MyCampingController controller = Get.put(MyCampingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: CustomAppBar(
              backgroundColor: AppColors.white,
              title: controller.campinAppBar,
              onTap: () {
                if (controller.selectedProgram != null) {
                  controller.selectedProgram = null;
                } else {
                  Navigator.of(context).pop();
                }
                controller.update();
                controller.campinAppBar = 'my_camping_title'.tr;
              },
            ),
            body: GetBuilder<MyCampingController>(
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: controller.selectedProgram != null
                      ? DetailsProgramCampingWidget()
                      : Column(
                          children: [
                            Container(
                              height: 1.h,
                              color: AppColors.greyVerfication,
                            ),
                            SizedBox(height: 40.h),
                            Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColors.containerGrey,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTap(
                                    width: 180.w,
                                    color: controller.selectedTab.value == CampingEnum.program
                                        ? AppColors.primary
                                        : AppColors.containerGrey,
                                    text: 'program'.tr,
                                    textColor: controller.selectedTab.value == CampingEnum.program
                                        ? AppColors.white
                                        : AppColors.textSecoundary,
                                    onTap: () {
                                      controller.changeTab(CampingEnum.program);
                                      controller.update();
                                    },
                                  ),
                                  CustomTap(
                                    width: 180.w,
                                    color: controller.selectedTab.value == CampingEnum.guide
                                        ? AppColors.primary
                                        : AppColors.containerGrey,
                                    text: 'guide'.tr,
                                    textColor: controller.selectedTab.value == CampingEnum.guide
                                        ? AppColors.white
                                        : AppColors.textSecoundary,
                                    onTap: () {
                                      controller.changeTab(CampingEnum.guide);
                                      controller.update();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            controller.selectedTab.value == CampingEnum.program
                                ? ListProgramCampingWidget()
                                : DetailsGuideCampingWidget(),
                          ],
                        ),
                );
              },
            ),
          );
  }
}