import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/individual_hajj_widget.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IndividualHajjScreen extends StatefulWidget {
  IndividualHajjScreen({super.key});
  
  @override
  State<IndividualHajjScreen> createState() => _IndividualHajjScreenState();
}

class _IndividualHajjScreenState extends State<IndividualHajjScreen> {
  final List<String> individuals = [
    'Ihram_from_Miqat'.tr,
    'tawaf_alqdom'.tr,
    'maqam_ibrahem'.tr,
    'water_zamzam'.tr,
    'safa_marwah'.tr,
    "staying_in_mecca".tr,
    'arrival_mina'.tr,
    'day_of_arafah'.tr,
    'stay_muzdalifah'.tr,
    'throwing_jamrat_al_aqabah'.tr,
    'slaughtering_hadi'.tr,
    'shaving_trimming'.tr,
    'tawaf_ifadah'.tr,
    'tashreeq_rituals'.tr,
    'tawaf_wada'.tr,
  ];
  final HajjRitualsController controller = Get.find<HajjRitualsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HajjRitualsController>(
      builder: (controller) {
        return PopScope(
            canPop: false,
            onPopInvoked: (_) async {
              if(controller.isShowManask){
                  controller.changeShowManask();
                }else
                      {Navigator.of(context).pushNamed(AppRoutesPath.Al_ArqamRitualsRoute);}

        // Replace pushNamed with pushAndRemoveUntil
      
        // return false; // Prevent default pop behavior
      },
          child: Scaffold(
            backgroundColor: AppColors.whiteBackground,
            appBar: CustomAppBar(
              backgroundColor: AppColors.whiteBackground,
              triling:CustomTrailing(),
              onTap:(){
                if(controller.isShowManask){
                  controller.changeShowManask();
                }else{
                   Navigator.of(context).pushNamed(AppRoutesPath.Al_ArqamRitualsRoute);
        
      
                }
              },
              title:controller.selectedTabHajj.value==HajjEnum.person? 'individual_hajj'.tr: 'qiran_hajj'.tr,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 1.h,
                      color: AppColors.greyVerfication,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 280.h,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/individual/ihram.png"),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(height: 20.h),
                    GetBuilder<MainController>(
                      builder: (mainController) {
                        return Visibility(
                           visible: !controller.isShowManask,
                          child: Column(
                            children: [
                              Padding(
                               padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: RichText(
                                  textAlign:TextAlign.justify,
                                  text: TextSpan(
                                    
                                      style:  TextStyle(
                                                   fontSize: mainController.fontSize.value+1.sp,
                                                   color:AppColors.black,
                                                   
                                              // fontWeight: FontWeight.w600,
                                              fontFamily: 'NotoKufiArabic',
                                                  ),
                                    children: [
                                      TextSpan(
                                        text:controller.selectedTabHajj.value==HajjEnum.person?
                                         'tamattu_intro_bold'.tr:"qiran_intro_bold".tr,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        
                                        text:controller.selectedTabHajj.value==HajjEnum.person?
                                         'tamattu_intro_rest'.tr:
                                         "qiran_intro_rest".tr,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               SizedBox(height: 10.h),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 120.w),
                                    child: CustomButton(
                                      height: 90.h,
                                      onPressed: () {
                                        controller.changeShowManask();
                                      },
                                      borderRadius: 20.r,
                                      borderColor: AppColors.primary,
                                      isFillColor: false,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                             'manasik_title'.tr,
                                             style:  TextStyle(
                                                   fontSize: mainController.fontSize.value+1.sp,
                                                   color:AppColors.primary,
                                                   
                                              // fontWeight: FontWeight.w600,
                                              fontFamily: 'NotoKufiArabic',
                                                  ),
                                            
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        );
                      }
                    ),
                  
                  
                  
                    Visibility(
                      visible: controller.isShowManask,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: individuals.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: index==9,
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(vertical:10.h,horizontal:5.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(horizontal:5.w),
                                              height:2.h,color:AppColors.primary),
                                          ),
                                          Text('eid_day_acts'.tr,style:TextStyle(color:AppColors.primary,fontSize:14.sp,fontWeight:FontWeight.bold)),
                                       Expanded(
                                         child: Container(
                                          margin: EdgeInsets.symmetric(horizontal:5.w),
                                          height:2.h,color:AppColors.primary),
                                       ),
                                        ],
                                      ),
                                    ),
                                  ),
                                   Visibility(
                                    visible: index==13,
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(vertical:15.h,horizontal:5.w),
                                      child: Row(
                                        children: [
                                          Expanded(child: Container(height:2.h,color:AppColors.primary)),
                                      //     Text('أعمال يوم العيد',style:TextStyle(color:AppColors.primary,fontSize:14.sp)),
                                      //  Container(height:2.h,width:140.w,color:AppColors.primary),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IndividualHajjWidget(index: index, title: individuals[index]),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                 
                 
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}