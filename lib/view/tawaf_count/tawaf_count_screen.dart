
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_type.dart';
import 'package:Al_Arqam/core/enums/twaff_enum.dart';
import 'package:Al_Arqam/view/tawaf_count/controller/twaff_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text10.dart';
import 'package:Al_Arqam/core/resources/text/text24.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:Al_Arqam/view/tawaf_count/bloc/tawaf_count_bloc.dart';
import 'package:Al_Arqam/view/tawaf_count/widgets/twaf_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';


class TawafCountScreen extends StatefulWidget {
  const TawafCountScreen({super.key});

  @override
  State<TawafCountScreen> createState() => _TawafCountScreenState();
}

class _TawafCountScreenState extends State<TawafCountScreen> {
  late TawafCountBloc tawafCountBloc;
  late Color progressColor;

  @override
  void initState() {
    super.initState();
   
    tawafCountBloc = TawafCountBloc();
    progressColor = AppColors.primary;
  }
  TwaffController twaffcontroller=Get.put(TwaffController());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => tawafCountBloc,
      child: GetBuilder<MainController>(
        builder: (controller) {
          return GetBuilder<TwaffController>(
            builder: (twaffcontroller) {
              return Container(
                
               
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar:  CustomAppBar(title:"tawaf_count".tr,
                  backgroundColor: Colors.white,
                  onTap:(){
                     if(twaffcontroller.isStart){
                      twaffcontroller.changeIsStart();
                     }else
                    {Get.back();}
                  },
                  // backgroundColor: AppColors.whiteBackground,
                  triling:CustomTrailing() ),
                  body: BlocBuilder<TawafCountBloc, TawafCountState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          Container(
                              padding: EdgeInsetsDirectional.symmetric(vertical:40.h),
        decoration: const BoxDecoration(

          image: DecorationImage(
            image: AssetImage('assets/images/count.jpeg'),
             opacity: 1,
            fit: BoxFit.cover,
          ),
        ),
                          ),
                          Container(
                            color:Colors.white.withOpacity(!twaffcontroller.isStart?0.0:0.86),
                            child: Padding(
                                padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                              child: Center(
                                child: !twaffcontroller.isStart
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                            Container(
                            height: 1.h,
                            color: AppColors.greyVerfication,
                                                    ),
                                                    SizedBox(height: 40.h),
                                       
                                          Padding(
                                      padding: EdgeInsets.all(8.w),
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
                                              width: 170.w,
                                              color: controller.selectedTwaffTab.value == TwaffEnum.twaff
                                                  ? AppColors.primary
                                                  : AppColors.containerGrey,
                                              text: "tawaf".tr,
                                              textColor: controller.selectedTwaffTab.value == TwaffEnum.twaff
                                                  ? AppColors.white
                                                  : AppColors.textSecoundary,
                                              onTap: () {
                                                controller.changeTabTwaff(TwaffEnum.twaff);
                                                controller.update();
                                              },
                                            ),
                                            CustomTap(
                                              width: 170.w,
                                              color: controller.selectedTwaffTab.value == TwaffEnum.saee
                                                  ? AppColors.primary
                                                  : AppColors.containerGrey,
                                              text: "saee".tr,
                                              textColor: controller.selectedTwaffTab.value == TwaffEnum.saee
                                                  ? AppColors.white
                                                  : AppColors.textSecoundary,
                                              onTap: () {
                                                controller.changeTabTwaff(TwaffEnum.saee);
                                                controller.update();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                     
                                     
                                     
                                       SizedBox(
                                            height: 60.h,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 200.w,
                                            height: 200.w,
                                            decoration: BoxDecoration(
                                              // ignore: deprecated_member_use
                                              color: AppColors.primary.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(250.r),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: AppColors.containerGrey,
                                                    spreadRadius: 20,
                                                    blurRadius: 20,
                                                    // offset: const Offset(4, 4),
                                                    blurStyle: BlurStyle.solid),
                                              ],
                                            ),
                                            child: CustomButton(
                                                width: 150.w,
                                                height: 200.w,
                                                borderRadius: 250.r,
                                                child: Text24(
                                                  text: "start".tr,
                                                  isBold: true,
                                                  color: AppColors.white,
                                                ),
                                                onPressed: () {
                                                  twaffcontroller.changeIsStart();
                                                  tawafCountBloc.add(ClearState());
                                                }),
                                          ),
                                          SizedBox(
                                            height: 75.h,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.containerGrey,
                                              borderRadius: BorderRadius.circular(25.r),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(15.w),
                                              child:  Text10(
                                                text:"tawaf_description".tr
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                            
                                        children: [
                                            Container(
                            height: 1.h,
                            color: AppColors.greyVerfication,
                                                    ),
                                                    SizedBox(height: 20.h),
                                                     Padding(
                                      padding: EdgeInsets.all(8.w),
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
                                              width: 170.w,
                                              color: controller.selectedTwaffTabHajj.value == TwaffWaysEnum.manask
                                                  ? AppColors.primary
                                                  : AppColors.containerGrey,
                                              text: "rituals".tr,
                                              textColor: controller.selectedTwaffTabHajj.value == TwaffWaysEnum.manask
                                                  ? AppColors.white
                                                  : AppColors.textSecoundary,
                                              onTap: () {
                                                controller.changeTabTwaffWay(TwaffWaysEnum.manask);
                                                controller.update();
                                              },
                                            ),
                                            CustomTap(
                                              width: 170.w,
                                              color:controller.selectedTwaffTabHajj.value == TwaffWaysEnum.dwa
                                                  ? AppColors.primary
                                                  : AppColors.containerGrey,
                                              text: "supplication".tr,
                                              textColor: controller.selectedTwaffTabHajj.value == TwaffWaysEnum.dwa
                                                  ? AppColors.white
                                                  : AppColors.textSecoundary,
                                              onTap: () {
                                                controller.changeTabTwaffWay(TwaffWaysEnum.dwa);
                                                controller.update();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                     
                                        SizedBox(height: 20.h),
                                          InkWell(
                                            onTap:(){
                                               if (state.round <7 ) {
                                            tawafCountBloc.add(IncreaseCountEvent());
                                               print('rrrrrrrrrrrrrrrrrrr${state.round}');
                                            twaffcontroller.chooseSaiInstructions(state.round);
                                            twaffcontroller.chooseTawafInstructions(state.round);
                                              twaffcontroller.chooseTawafDwa(state.round);
                                              twaffcontroller.chooseSaeeDwa(state.round);
                                          }
                                            },
                                            child: CircularPercentIndicator(
                                              radius: 90.w,
                                              lineWidth: 18.w,
                                              //startAngle: pi / 4,
                                              percent:state.round!=0? state.count / 1.001:0,
                                                                        
                                              center: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                    Image.asset(
                                                              state.round==7?  AppImages.twaf:AppImages.twaff,
                                                                 height: 80.h,
                                                                  width: 80.h,
                                                                // color: AppColors.white,
                                                              ),
                                                              SizedBox(height: 8.h,),
                                                  Text24(text: "${state.round}/7"),
                                                                        
                                                ],
                                              ),
                                              backgroundColor: AppColors.greyVerfication,
                                              progressColor: state.round == 7
                                                  ? AppColors.green
                                                  : AppColors.primary,
                                              circularStrokeCap: CircularStrokeCap.round,
                                              animation: true,
                                              animationDuration: 1000,
                                              animateFromLastPercent: true,
                                            ),
                                          ),
                                           Visibility(
                                            visible:state.round!=0,
                                             child: Expanded(child: PilgrimageScreen(
                                             description:  controller.selectedTwaffTab.value == TwaffEnum.saee?
                                             controller.selectedTwaffTabHajj.value == TwaffWaysEnum.dwa?
                                             twaffcontroller.saeedwaSelected:
                                              twaffcontroller.saiInstructionsSelected:
                                              controller.selectedTwaffTabHajj.value == TwaffWaysEnum.dwa?
                                              twaffcontroller.tawafdwaSelected:
                                              twaffcontroller.tawafInstructionsSelected,
                                             
                                                                               )),
                                           ),
                                          // const Expanded(child: Text24(text: "الدعاء")),
                                         
                                      
                                        ],
                                      ),
                              ),
                            ),
                          ),     
                             
                                                        Directionality(
                                textDirection:TextDirection.rtl,
                                child: Visibility(
                                  visible: twaffcontroller.isStart,
                                          
                                  child: Positioned(
                                    bottom: 10.h,
                                    left:10.w,
                                    child: InkWell(
                                      onTap: () async {
                                          if (state.round <7 ) {
                                            tawafCountBloc.add(IncreaseCountEvent());
                                               print('rrrrrrrrrrrrrrrrrrr${state.round}');
                                            twaffcontroller.chooseSaiInstructions(state.round);
                                            twaffcontroller.chooseTawafInstructions(state.round);
                                              twaffcontroller.chooseTawafDwa(state.round);
                                              twaffcontroller.chooseSaeeDwa(state.round);
                                          }
                                      },
                                      child: Container(
                                       alignment: Alignment.center,
                              padding: EdgeInsets.symmetric( vertical:10.h,horizontal:10.w),
                                                decoration: BoxDecoration(
                          color: state.round!=7? AppColors.primary: AppColors.greyVerfication,
                          
                          borderRadius: BorderRadius.circular(14.sp)),
                                    
                                        
                                        
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColors.white,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                                        ),
                                  Directionality(
                                     textDirection:TextDirection.rtl,
                                    child: Visibility(
                                                        visible:twaffcontroller.isStart,
                                          
                                                        child: Positioned(
                                    bottom: 10.h,
                                    right:10.w,
                                    child: InkWell(
                                      onTap:state.round==0?(){}: () async {
                                                          if (state.round >= 0) {
                                                              print('rrrrrrrrrrrrrrrrrrr${state.round}');
                                                            tawafCountBloc.add(DecreaseCountEvent());
                                                            print('rrrrrrrrrrrrrrrrrrr${state.round}');
                                                            twaffcontroller.chooseSaiInstructions(state.round-2);
                                                          twaffcontroller.chooseTawafInstructions(state.round-2);
                                                          twaffcontroller.chooseTawafDwa(state.round-2);
                                                          twaffcontroller.chooseSaeeDwa(state.round-2);
                                                          }
                                                        } ,
                                      child:  Container(
                                                       alignment: Alignment.center,
                              padding: EdgeInsets.symmetric( vertical:10.h,horizontal:10.w),
                                                decoration: BoxDecoration(
                          color: state.round!=0&&state.round!=-1? AppColors.primary: AppColors.greyVerfication,
                          
                          borderRadius: BorderRadius.circular(14.sp)),
                                                         
                                                        
                                                        child: Padding(
                                                             padding:  EdgeInsets.only(left:0.w),
                                                          child: Icon(
                                                            Icons.arrow_back_ios,
                                                            color: AppColors.white,
                                                            size: 20.sp,
                                                          ),
                                                        ),
                                                      ),
                                    ),
                                                        ),
                                                      ),
                                  ),
                           
                           
                        ],
                      );
                    },
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}
