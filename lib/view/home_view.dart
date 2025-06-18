import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_language_toggle.dart';
import 'package:Al_Arqam/core/app/general_widgets/drawer.dart';
import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text10.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/view/ask_camping_mufti/controller/ask_camping_mufti_controller.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:Al_Arqam/view/home/widgets/custom_home_button.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AskCampingMuftiController controllerAsk =
      Get.find<AskCampingMuftiController>();
  MainController controller = Get.find<MainController>();

  final List<IconData> prayerIcon = [
    Iconsax.sun_fog,
    Iconsax.sun_1,
    Iconsax.sun_1,
    Iconsax.sun_fog5,
    Iconsax.moon,
  ];
  final List<String> prayerName = [
    "fajr",
    "dhuhr",
    "asr",
    "maghrib",
    "isha",
  ];
  List<String> prayerTimesList = [
    "...",
    "...",
    "...",
    "...",
    "...",
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HajjRitualsController hajjController = Get.find<HajjRitualsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AskCampingMuftiController>(builder: (controllerAsk) {
      return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        drawer: Drawer(
          child: CustomDrawer(scaffoldKey: _scaffoldKey),
        ),
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          isBackIconVisible: false,
          title: "welcome".tr,
          titleColor: AppColors.white,
          scaffoldKey: _scaffoldKey,
          triling: AnimatedToggle(
            values: ['Ar', 'En'],
            onToggleCallback: (value) {
              print(value);
              setState(() {
                // _toggleValue = value;
              });
            },
            buttonColor: const Color(0xFF0A3157),
            backgroundColor: const Color(0xFFB5C1CC),
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            //  controller.fetchPrayerTimes(double.parse(controller.currentPosition.split(" ")[0]), double.parse(controller.currentPosition.split(" ")[1]));

            controller.fetchCampaign();
            controller.fetchMedicins();

            controller.getCurrentLocation();
            controller.update();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 0,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().screenHeight / 3.7,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImages.kaabaBackground)),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(24))),
                    child: SizedBox(
                      child: Stack(
                        children: [
                          Image.asset(
                            width: double.infinity,
                            AppImages.kaabaBackground,
                            fit: BoxFit.fill,
                          ),
                          // Text16(
                          //     text: state.prayerTimesModel!.data!.timings!
                          //         .firstthird!),

                          GetBuilder<MainController>(builder: (mainController) {
                            return Container(
                              alignment: Alignment.center,
                              height: ScreenUtil().screenHeight / 9,
                              margin: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                bottom: 10,
                                top: ScreenUtil().screenHeight / 7,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 7),
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    String prayerTime = "";
                                    // Ensure you're getting the correct prayer time
                                    switch (index) {
                                      case 0:
                                        prayerTime =
                                            mainController.times['Fajr'] ??
                                                '...';
                                        break;
                                      case 1:
                                        prayerTime =
                                            mainController.times['Dhuhr'] ??
                                                '...';
                                        break;
                                      case 2:
                                        prayerTime =
                                            mainController.times['Asr'] ??
                                                '...';
                                        break;
                                      case 3:
                                        prayerTime =
                                            mainController.times['Maghrib'] ??
                                                '...';
                                        break;
                                      case 4:
                                        prayerTime =
                                            mainController.times['Isha'] ??
                                                '...';
                                        break;
                                    }

                                    return Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 3.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 3.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(prayerIcon[
                                                index]), // Ensure prayerIcon is defined
                                            Text10(
                                                text: prayerName[index]
                                                    .tr), // Ensure prayerName is defined
                                            Text10(
                                                text:
                                                    prayerTime), // Use the fetched prayer time
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 15.h),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: GlobalFunctions.isAuth(),
                                  child: CustomButton(
                                    backgroundColor: AppColors.error,
                                    onPressed: () {
                                      controller.sendMessage();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.alarm5,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text14(
                                          text: 'emergency'.tr,
                                          isBold: true,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Visibility(
                                  visible: GlobalFunctions.isAuth(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text14(
                                              text: "medicine_reminder".tr,
                                              isBold: true,
                                            ),
                                            CustomButton(
                                                backgroundColor:
                                                    AppColors.containerGrey,
                                                height: 50.h,
                                                child: Text12(
                                                  text: "add_reminder".tr,
                                                  textAlign: TextAlign.center,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(AppRoutesPath
                                                          .medicinereminderRoute);
                                                })
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      GetBuilder<MainController>(
                                          builder: (controller) {
                                        return CustomButton(
                                          backgroundColor: AppColors.error,
                                          isFillColor: false,
                                          onPressed: () {},
                                          borderColor: AppColors.primary,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Iconsax.health,
                                                color: AppColors.primary,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text12(
                                                text: controller
                                                        .medicines.isEmpty
                                                    ? "${"next_appointment".tr}:  ....."
                                                    : "${"next_appointment".tr}: ${controller.medicines[0].medicine!.schedule!.times}  ${controller.medicines[0].medicine!.schedule!.date}",
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text14(
                                        text: "quick_shortcuts".tr,
                                        isBold: true,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    CustomHomeButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              AppRoutesPath
                                                  .recordedSupplicationsRoute);
                                        },
                                        icon: Icon(
                                          Iconsax.message_text5,
                                          color: AppColors.white,
                                          size: 15,
                                        ),
                                        title: "remembrances".tr),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CustomHomeButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              AppRoutesPath.myCampingRoute);
                                        },
                                        icon: Icon(
                                          Iconsax.flag5,
                                          color: AppColors.white,
                                          size: 15,
                                        ),
                                        title: "the_campaign".tr)
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    CustomHomeButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              AppRoutesPath
                                                  .Al_ArqamRitualsRoute);
                                        },
                                        icon: Image.asset(
                                          AppImages.kaaba,
                                          height: 15.h,
                                          color: AppColors.white,
                                        ),
                                        title: "hajj_rituals_title".tr),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CustomHomeButton(
                                      onPressed: () {
                                        hajjController.selectedTabHajj.value =
                                            HajjEnum.umrah;
                                        hajjController.changeIndexManask(0);
                                        hajjController
                                            .changeIndexManaskTamatoa(0);
                                        Navigator.of(context).pushNamed(
                                            AppRoutesPath.AmraaRitualsScreen);
                                      },
                                      icon: Image.asset(
                                        AppImages.kaaba,
                                        height: 15.h,
                                        color: AppColors.white,
                                      ),
                                      title: 'rituals_of_umrah'.tr,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text16(
                                        text: "question_and_fatwa".tr,
                                        isBold: true,
                                      ),
                                      CustomButton(
                                          backgroundColor:
                                              AppColors.containerGrey,
                                          height: 50.h,
                                          child: Text12(
                                            text: "show_more".tr,
                                            textAlign: TextAlign.center,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                AppRoutesPath.askCampingMufti);
                                          })
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                // if (state.getQuestionsStatus ==
                                //     GetQuestionsStatus.load) {
                                //   return GlobalFunctions.showLoading(
                                //       AppColors.primary);
                                // }
                                // if (state.getQuestionsStatus ==
                                //     GetQuestionsStatus.fail) {
                                //   return Text14(text: state.message);
                                // }

                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                              bottomRight: Radius.circular(25)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text14(
                                                textAlign: TextAlign.start,
                                                text: "question".tr),
                                            AutoSizeText(
                                              maxLines: 2,
                                              controllerAsk
                                                          .inquiriesResponse
                                                          .value
                                                          .inquiries
                                                          .isEmpty ||
                                                      !GlobalFunctions.isAuth()
                                                  ? "missed_arafah_due_to_excuse_q"
                                                      .tr
                                                  : controllerAsk
                                                      .inquiriesResponse
                                                      .value
                                                      .inquiries[0]
                                                      .question!,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        width: double.infinity,
                                        margin: EdgeInsets.only(top: 10.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(25)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text14(
                                                textAlign: TextAlign.start,
                                                text: "answer".tr),
                                            AutoSizeText(
                                              maxLines: 3,
                                              controllerAsk
                                                          .inquiriesResponse
                                                          .value
                                                          .inquiries
                                                          .isEmpty ||
                                                      !GlobalFunctions.isAuth()
                                                  ? "missed_arafah_due_to_excuse_a"
                                                      .tr
                                                  : controllerAsk
                                                      .inquiriesResponse
                                                      .value
                                                      .inquiries[0]
                                                      .answer!,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
