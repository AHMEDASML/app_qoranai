import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/individual_hajj_widget.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/tomato_hajj_widget.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AmraaRitualsScreen extends StatefulWidget {
  AmraaRitualsScreen({super.key});
  
  @override
  State<AmraaRitualsScreen> createState() => _AmraaRitualsScreenState();
}

class _AmraaRitualsScreenState extends State<AmraaRitualsScreen> {
  final List<String> individuals = [
    'Ihram_from_Miqat'.tr,
    'tawaf_of_umrah'.tr,
    'maqam_ibrahim'.tr,
    'water_zamzam'.tr,
    'safa_marwah'.tr,
    'shaving_trimming'.tr,
    
  ];
  final HajjRitualsController controller = Get.find<HajjRitualsController>();
  @override
  Widget build(BuildContext context) {
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
          backgroundColor: AppColors.whiteBackground,
          title: 'rituals_of_umrah'.tr,
          onTap:(){
             Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
          },
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
                Container(
                  height: 280.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/individual/ihram.png"),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: individuals.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: TomatoHajjWidget(index: index, title: individuals[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}