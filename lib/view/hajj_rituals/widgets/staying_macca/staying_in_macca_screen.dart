import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_back.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_forword.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_popup_fontsize.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_type.dart';
import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/enums/hajj_rituals_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/hajj_rituals/individual_hajj_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/tamtao_hajj_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/coming_to_mina/mistakes_coming_to_mina_widget.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/coming_to_mina/text_coming_to_mina_widget.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/staying_macca/mistakes_staying_in_macca_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/staying_macca/text_staying_in_macca_screen.dart';

import 'package:Al_Arqam/view/hajj_rituals/widgets/water_zamzam.dart/mistakes_water_zamzam_widget.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/water_zamzam.dart/text_water_zamzam_widget.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StayingInMaccaScreen extends StatefulWidget {
  StayingInMaccaScreen({super.key});

  HajjRitualsController hajjController = Get.find<HajjRitualsController>();

  @override
  State<StayingInMaccaScreen> createState() => _StayingInMaccaScreenState();
}

class _StayingInMaccaScreenState extends State<StayingInMaccaScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HajjRitualsController>(
      builder: (hajjController) {
        return PopScope(
           canPop: false,
          onPopInvoked:(_){
            if(hajjController.selectedTabHajj.value ==
                                            HajjEnum.tamtoa){
  Get.to(TamtaoHajjScreen());
                                            }else if(hajjController.selectedTabHajj.value ==
                                            HajjEnum.umrah){
 Navigator.of(context).pushNamed(AppRoutesPath.AmraaRitualsScreen);

                                            }
            
              else {Get.to(IndividualHajjScreen());}
               
          },
          child: Scaffold(
            backgroundColor: AppColors.whiteBackground,
            appBar: CustomAppBar(
              backgroundColor: AppColors.whiteBackground,
              onTap:(){
                 if(hajjController.selectedTabHajj.value ==
                                            HajjEnum.tamtoa){
  Get.to(TamtaoHajjScreen());
                                            }else if(hajjController.selectedTabHajj.value ==
                                            HajjEnum.umrah){
 Navigator.of(context).pushNamed(AppRoutesPath.AmraaRitualsScreen);

                                            }
            
              else {Get.to(IndividualHajjScreen());}
              },
              title: hajjController.selectedTabHajj.value==HajjEnum.person?
              
               'individual_hajj'.tr:
                hajjController.selectedTabHajj.value==HajjEnum.tamtoa?
                'tamattu_hajj'.tr:
                'qiran_hajj'.tr,
                subTitle:'staying_in_mecca'.tr,
                isManask:true,
              triling:CustomTrailing()
            ),
            body: GetBuilder<MainController>(
              builder: (controller) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 1.h,
                                color: AppColors.greyVerfication,
                              ),
                              Container(
                                height: 200.h,
                                // width:400.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover ,
                                    image: AssetImage("assets/images/mina.jpeg"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Container(
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
                                        color: hajjController.selectedTab.value == HajjRitualsEnum.text
                                            ? AppColors.primary
                                            : AppColors.containerGrey,
                                        text: "explanation_of_ritual".tr,
                                        textColor: hajjController.selectedTab.value == HajjRitualsEnum.text
                                            ? AppColors.white
                                            : AppColors.textSecoundary,
                                        onTap: () {
                                          hajjController.changeTab(HajjRitualsEnum.text);
                                          hajjController.update();
                                        },
                                      ),
                                      CustomTap(
                                        width: 180.w,
                                        color: hajjController.selectedTab.value == HajjRitualsEnum.mistakes
                                            ? AppColors.primary
                                            : AppColors.containerGrey,
                                        text: "mistakes_of_ritual".tr,
                                        textColor: hajjController.selectedTab.value == HajjRitualsEnum.mistakes
                                            ? AppColors.white
                                            : AppColors.textSecoundary,
                                        onTap: () {
                                          hajjController.changeTab(HajjRitualsEnum.mistakes);
                                          hajjController.update();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.containerGrey,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: hajjController.selectedTab.value == HajjRitualsEnum.text
                                    ? TextStayingInMaccaScreen()
                                    : MistakesStayingInMaccaScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                   CustomForword(),
                   
                   CustomBack(),
                  
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}