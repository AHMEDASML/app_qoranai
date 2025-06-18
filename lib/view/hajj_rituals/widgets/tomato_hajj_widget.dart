import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TomatoHajjWidget extends StatelessWidget {
  int index;
   String title;
   TomatoHajjWidget({super.key,required this.index,required this.title});
  HajjRitualsController hajjController = Get.find<HajjRitualsController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
      hajjController.changeIndexManaskTamatoa(index);

        if(index==0)
        {Get.to(DetailsIndividualHajjScreen());}
        else if(index==1){
Get.to(TwaffAlqdomScreen());
        }
        else if(index==2){
Get.to(MaqamIbrahemScreen());
        }
         else if(index==3){
Get.to(WaterZamzamScreen());
        }
         else if(index==4){
Get.to(BetweenSafaAndMarwahScreen());
        }
          else if(index==5){
Get.to(ShavingTrimmingScreen(flag: true,));
        }
         else if(index==6){
Get.to(StayingInMaccaScreen());
        }
         else if(index==7){
Get.to(ComingToMinaScreen());
        }
           else if(index==8){
Get.to(DayOfArafahScreen());
        }
          else if(index==9){
Get.to(StayInMuzdalifahScreen());
        }
         else if(index==10){
Get.to(ThrowingTheJamratScreen());
        }
         else if(index==11){
Get.to(SlaughteringHadiScreen());
        }
        else if(index==12){
Get.to(ShavingTrimmingScreen());
        }
          else if(index==13){
Get.to(TawafIfadahScreen());
        }
        else if(index==14){
Get.to(ThrowingJamratScreen());
        }
         else if(index==15){
Get.to(TawafWadaScreen());
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color:AppColors.primary)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                
                child:Row(
                  children: [
                       SizedBox(width:4.w),
                    Container(
                      width:30.w,
                height:30.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary
                      ),
                      child:Center(child: Text12(text:"${index+1}".toString(),color:AppColors.white,)),
                    ),
                    SizedBox(width:10.w),
                    Text12(text: title)
                  ],
                ),
      
              )
            ],),
            Padding(
              padding:  EdgeInsets.all(4.w),
              child: Image.asset(
                                   width:30.w,
                  index==1||index==13||index==2||index==3||index==15||index==6?
                   "assets/images/individual/im_2.png":
                   index==10||index==14?
                   
                   "assets/images/individual/im_7.png":
                    index==5?
                   
                   "assets/images/individual/im_9.png":
                   index==4?
                   "assets/images/individual/im_3.png":
                   index==0?
                    "assets/images/individual/im_1.png":
                 "assets/images/individual/im_${index-3}.png"),
            )
          ],
        ),
      
      
      ),
    );
  }
}