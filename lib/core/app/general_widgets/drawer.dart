import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/auth/controller/auth_controller.dart';
import 'package:Al_Arqam/view/hajj_rituals/widgets/maqam_ibrahem/maqam_ibrahem_screen.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../view/main/main_screen.dart';

class CustomDrawer extends StatefulWidget {
  final int currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomDrawer(
      {super.key, this.currentPage = 0, required this.scaffoldKey});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<String> drawerTitles = [];
  List<void Function()?> drawerFunction = [];
  MainController controller=Get.find<MainController>();
  AuthController authController=Get.put(AuthController());
  @override
  void initState() {
    drawerFunction = [
      () {
         Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.myCampingRoute);
      },
      () {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainScreen(
                currentPage: AppRoutesPath.medicinereminderRoute,
              ),
            ),
            (val) => false);
      },
      () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.compassRoute);
      },
      () {
         Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.recordedSupplicationsRoute);
      },
      () {
          Navigator.of(context).pop();
       Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainScreen(
                currentPage: AppRoutesPath.quranRoute,
              ),
            ),
            (val) => false);
      },
      () {
            Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.Al_ArqamRitualsRoute);
      },
      () {
        hajjController.selectedTabHajj.value=HajjEnum.umrah;
         hajjController.changeIndexManask(0);
                     hajjController.changeIndexManaskTamatoa(0);
     Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.AmraaRitualsScreen);
      },
 () {
          Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.miqatscreen);
      },
       () {
          Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.prohibitionofihramscreen);
      },

      () {
          Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.tawafCountRoute);
      },
      () {
        controller.showMap.value=true;
        controller.showLocation.value=false;
        controller.update();
             Navigator.of(context).pop();
       Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainScreen(
                currentPage: AppRoutesPath.CustomGoogleMap,
              ),
            ),
            (val) => false);
      },
      
      () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.crowadingRoute);
      },
      () {
          Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.askCampingMufti);
      },
     
      () {
          Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.aboutUsRoute);
      },
      () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.myCampingRoute);
      },
      GlobalFunctions.isAuth()?
      (){
       authController.logout(context);
      }:
       () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.loginRoute);
       },
    ];
    drawerTitles = [
      "my_camping".tr,
      "health_record".tr,
      "compass_title".tr,
      "recorded_supplications".tr,
      "quran".tr,
      "hajj_rituals_title".tr,
      'rituals_of_umrah'.tr,
      "miqats".tr,
      "prohibitions".tr,
      "tawaf_count".tr,
      "guide_me".tr,
      "crowding_status".tr,
      "ask_mufti".tr, 
      "about_us_title".tr,
      "support_numbers".tr,
      GlobalFunctions.isAuth()?"logout".tr:"login_or_create_account".tr
    ];
    //  drawerTitlesAuth = [
    //   "حملتي",
    //   "السجل الصحّي",
    //   "البوصلة",
    //   "الأدعية المسموعة",
    //   "القرآن الكريم",
    //   "مناسك الحج",
    //   "مناسك العمرة",
    //   "عد الطواف",
    //   "أرشدني",
    //   "حالة الزحام",
    //   "اسأل مفتي الحملة",
    //   "الطوارئ",
    //   "من نحن",
    //   "أرقام الدعم",
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
           CustomAppBar(title: "menu".tr),
          SizedBox(
            height: 10.h,
          ),
          ...List.generate(
            drawerTitles.length,
            (index) => InkWell(
              onTap: drawerFunction[index],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text14(text: drawerTitles[index]),
                    ),
                    Divider(
                      color: AppColors.greyVerfication,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
