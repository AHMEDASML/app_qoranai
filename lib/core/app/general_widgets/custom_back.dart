import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/between_safa_and_marwah/between_safa_and_marwah_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/coming_to_mina/coming_to_mina_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/day_of_arafah/day_of_arafah_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/ihram_from_miqat/ihram_from_miqat_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/maqam_ibrahem/maqam_ibrahem_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/shaving_trimming/shaving_trimming_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/slaughtering_hadi/slaughtering_hadi_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/stay_in_muzdalifah/stay_in_muzdalifah_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/staying_macca/staying_in_macca_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/tawaf_ifadah/tawaf_ifadah_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/tawaf_wada/tawaf_wada_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/throwing_jamrat/throwing_jamrat_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/throwing_the_jamrat/throwing_the_jamrat_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/twaff_alqdom/twaff_alqdom_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/water_zamzam.dart/water_zamzam_screen.dart';
class CustomBack extends StatelessWidget {
   CustomBack({super.key});
  HajjRitualsController hajjController = Get.find<HajjRitualsController>();
  List<Widget> manasks=
  [
    DetailsIndividualHajjScreen(),
    TwaffAlqdomScreen(),
    MaqamIbrahemScreen(),
    WaterZamzamScreen(),
    BetweenSafaAndMarwahScreen(),
    StayingInMaccaScreen(),
    ComingToMinaScreen(),
    DayOfArafahScreen(),
    StayInMuzdalifahScreen(),
    ThrowingTheJamratScreen(),
    SlaughteringHadiScreen(),
    ShavingTrimmingScreen(),
    TawafIfadahScreen(),
    ThrowingJamratScreen(),
    TawafWadaScreen()

  ];
  List<Widget> manasksTamatoa=
  [
    DetailsIndividualHajjScreen(),
    TwaffAlqdomScreen(),
    MaqamIbrahemScreen(),
    WaterZamzamScreen(),
    BetweenSafaAndMarwahScreen(),
    ShavingTrimmingScreen(flag: true,),
    StayingInMaccaScreen(),
    ComingToMinaScreen(),
    DayOfArafahScreen(),
    StayInMuzdalifahScreen(),
    ThrowingTheJamratScreen(),
    SlaughteringHadiScreen(),
    ShavingTrimmingScreen(),
    TawafIfadahScreen(),
    ThrowingJamratScreen(),
    TawafWadaScreen()

  ];
  @override
  Widget build(BuildContext context) {
    return   Directionality(
                    textDirection: TextDirection.rtl,
                    child: Visibility(
                      visible: true,
                      child: Positioned(
                        bottom: 10.h,
                        right: 10.w,
                        child: InkWell(
                          onTap: ((hajjController.selectedTabHajj.value ==
                                          HajjEnum.tamtoa||hajjController.selectedTabHajj.value ==
                                      HajjEnum.umrah) &&
                                      hajjController.indexManaskTamatoa ==
                                          0) ||
                                  (hajjController.selectedTabHajj.value !=
                                          HajjEnum.tamtoa&&hajjController.selectedTabHajj.value !=
                                          HajjEnum.umrah &&
                                      hajjController.indexManask == 0)
                              ? () {}
                              : () {
                                  if (hajjController.selectedTabHajj.value ==
                                      HajjEnum.tamtoa||hajjController.selectedTabHajj.value ==
                                      HajjEnum.umrah) {
                                    if (hajjController.indexManaskTamatoa >
                                        0) {
                                      hajjController.changeIndexManaskTamatoa(
                                          hajjController.indexManaskTamatoa -
                                              1);
                                      Get.to(manasksTamatoa[
                                          hajjController.indexManaskTamatoa]);
                                    }
                                  } else {
                                    if (hajjController.indexManaskTamatoa <
                                        14) {
                                      hajjController.changeIndexManask(
                                          hajjController.indexManask - 1);
                                      Get.to(manasks[
                                          hajjController.indexManask]);
                                    }
                                  }
                                },
                          child: Container(
                             alignment: Alignment.center,
                              padding: EdgeInsets.symmetric( vertical:10.h,horizontal:10.w),
                                                decoration: BoxDecoration(
                          color: ((hajjController
                                                .selectedTabHajj.value ==
                                            HajjEnum.tamtoa||hajjController.selectedTabHajj.value ==
                                        HajjEnum.umrah) &&
                                        hajjController.indexManaskTamatoa ==
                                            0) ||
                                    (hajjController.selectedTabHajj.value !=
                                            HajjEnum.tamtoa&&hajjController.selectedTabHajj.value !=
                                            HajjEnum.umrah &&
                                        hajjController.indexManask == 0)
                                ? AppColors.greyVerfication
                                : AppColors.primary,
                          
                          borderRadius: BorderRadius.circular(14.sp)),
                            // borderRadius: 25.r,
                            // height: 45.w,
                            // width: 45.w,
                          
                            // onPressed:state.round==0?(){}: () async {
                            //   if (state.round >= 0) {
                            //       print('rrrrrrrrrrrrrrrrrrr${state.round}');
                            //     tawafCountBloc.add(DecreaseCountEvent());
                            //     print('rrrrrrrrrrrrrrrrrrr${state.round}');
                            //     twaffcontroller.chooseSaiInstructions(state.round-2);
                            //   twaffcontroller.chooseTawafInstructions(state.round-2);
                            //   twaffcontroller.chooseTawafDwa(state.round-2);
                            //   twaffcontroller.chooseSaeeDwa(state.round-2);
                            //   }
                            // },
                            
                            
                             
                            child: Center(
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
                  );
                
                 
                 
  }
}