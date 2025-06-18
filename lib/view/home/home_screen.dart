// import 'package:Al_Arqam/core/app/general_widgets/custom_language_toggle.dart';
// import 'package:Al_Arqam/view/ask_camping_mufti/controller/ask_camping_mufti_controller.dart';
// import 'package:Al_Arqam/view/main_controller.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
// import 'package:Al_Arqam/core/app/general_widgets/drawer.dart';
// import 'package:Al_Arqam/core/app/params/home/prayers_params.dart';
// import 'package:Al_Arqam/core/app/params/inquiries/inquiries_params.dart';
// import 'package:Al_Arqam/core/config/permission.dart';
// import 'package:Al_Arqam/core/resources/asset_manger.dart';
// import 'package:Al_Arqam/core/resources/global_functions.dart';
// import 'package:Al_Arqam/core/resources/routes_manager.dart';
// import 'package:Al_Arqam/core/resources/text/text10.dart';
// import 'package:Al_Arqam/core/resources/text/text12.dart';
// import 'package:Al_Arqam/core/resources/text/text14.dart';
// import 'package:Al_Arqam/core/resources/text/text16.dart';
// import 'package:Al_Arqam/core/resources/text/text20.dart';

// import 'package:Al_Arqam/core/resources/toast.dart';
// import 'package:Al_Arqam/injection.dart';
// import 'package:Al_Arqam/models/home/prayer_times_model.dart';
// import 'package:Al_Arqam/view/home/bloc/home_bloc.dart';
// import 'package:Al_Arqam/view/home/widgets/custom_home_button.dart';
// import 'package:Al_Arqam/view/qustions/bloc/questions_bloc.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../core/app/general_widgets/custom_button.dart';
// import '../../core/resources/color_manager.dart';
// import '../medicine_reminder/bloc/medicin_reminder_bloc.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late HomeBloc bloc;
//   Position? currentLocation;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late MedicinReminderBloc medicinReminderBloc;
//   late QuestionsBloc questionsBloc;
//   final List<IconData> prayerIcon = [
//     Iconsax.sun_fog,
//     Iconsax.sun_1,
//     Iconsax.sun_1,
//     Iconsax.sun_fog5,
//     Iconsax.moon,
//   ];
//   final List<String> prayerName = [
//     "الفجر",
//     "الظهر",
//     "العصر",
//     "المغرب",
//     "العشاء",
//   ];
//   List<String> prayerTimesList = [
//     "...",
//     "...",
//     "...",
//     "...",
//     "...",
//   ];
//   Timings? prayerTime;
//   _getCurrentLocation() async {
//     print("vcdvzdvv");
//     Position? location = await LocationService.getCurrentLocation(context);
//     try {
//       setState(() {
//         currentLocation = location;
//       });
//       bloc.add(GetPrayerTimes(
//         prayersParams: PrayersParams(
//           latitude: currentLocation?.latitude ?? 21.422510,
//           longitude: currentLocation?.longitude ?? 39.826168,
//         ),
//       ));
//     } catch (e) {
//       print("error");
//     }
//   }

//   @override
//   void initState() {
//     _getCurrentLocation();
//     bloc = HomeBloc();
//     questionsBloc = serviceLocator.get<QuestionsBloc>()
//       ..add(GetQuestionsEvent(
//         inquiriesParams: InquiriesParams(
//             limit: 10, searchTerm: "", startIndex: 0, type: "public"),
//       ));
//     medicinReminderBloc = MedicinReminderBloc()..add(GetAllMedicins());
//     super.initState();
//   }
//   MainController controller=Get.find<MainController>();
//   AskCampingMuftiController controllerAsk=Get.find<AskCampingMuftiController>();
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => bloc,
//         ),
//         BlocProvider(
//           create: (context) => medicinReminderBloc,
//         ),
//         BlocProvider(create: (context) => questionsBloc),
//       ],
//       child: GetBuilder<AskCampingMuftiController>(
//         builder: (controllerAsk) {
//           return Scaffold(
//             extendBody: true,
//             extendBodyBehindAppBar: true,
//             key: _scaffoldKey,
//             drawer: Drawer(
//               child: CustomDrawer(scaffoldKey: _scaffoldKey),
//             ),
//             appBar: CustomAppBar(
//               backgroundColor: Colors.transparent,
//               isBackIconVisible: false,
//               title: "مرحباً بك",
//               titleColor: AppColors.white,
//               scaffoldKey: _scaffoldKey,
//               triling:  AnimatedToggle(
//               values: ['En', 'Ar'],
//               onToggleCallback: (value) {
//                 print(value);
//                 setState(() {
//                   // _toggleValue = value;
//                 });
//               },
//               buttonColor: const Color(0xFF0A3157),
//               backgroundColor: const Color(0xFFB5C1CC),
//               textColor: const Color(0xFFFFFFFF),
//             ),
//             ),
//             body: BlocConsumer<HomeBloc, HomeState>(
//               listener: (context, state) {
//                 if (state.prayerTimesStatus == PrayerTimesStatus.fail) {
//                   Toast.showText(text: state.massegeErrorPrayerTime);
//                 }
//                 if (state.prayerTimesStatus == PrayerTimesStatus.load) {
//                   prayerTimesList = [
//                     "...",
//                     "...",
//                     "...",
//                     "...",
//                     "...",
//                   ];
//                 }
//                 if (state.prayerTimesStatus == PrayerTimesStatus.succ &&
//                     state.prayerTimesModel != null) {
//                   prayerTime = state.prayerTimesModel!.data!.timings;
//                   prayerTimesList = [
//                     prayerTime?.fajr ?? "...",
//                     prayerTime?.dhuhr ?? "...",
//                     prayerTime?.asr ?? "...",
//                     prayerTime?.maghrib ?? "...",
//                     prayerTime?.isha ?? "...",
//                   ];
//                 }
//               },
//               builder: (context, state) {
//                 return RefreshIndicator(
//                   onRefresh: () async {
//                     bloc.add(GetPrayerTimes(
//                       prayersParams: PrayersParams(
//                         latitude: currentLocation?.latitude ?? 21.422510,
//                         longitude: currentLocation?.longitude ?? 39.826168,
//                       ),
//                     ));
//                     questionsBloc.add(GetQuestionsEvent(
//                       inquiriesParams: InquiriesParams(
//                           limit: 10,
//                           searchTerm: "",
//                           startIndex: 0,
//                           type: "public"),
//                     ));
//                     medicinReminderBloc.add(GetAllMedicins());
//                   },
//                   child: SingleChildScrollView(
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     child: Center(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                           minHeight: 0,
//                           maxHeight: MediaQuery.of(context).size.height,
//                         ),
//                         child: Column(
//                           children: [
//                             Container(
//                               width: double.infinity,
//                               height: ScreenUtil().screenHeight / 3.7,
//                               decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                       image:
//                                           AssetImage(AppImages.kaabaBackground)),
//                                   borderRadius: BorderRadius.vertical(
//                                       bottom: Radius.circular(24))),
//                               child: SizedBox(
//                                 child: Stack(
//                                   children: [
//                                     Image.asset(
//                                       width: double.infinity,
//                                       AppImages.kaabaBackground,
//                                       fit: BoxFit.fill,
//                                     ),
//                                     // Text16(
//                                     //     text: state.prayerTimesModel!.data!.timings!
//                                     //         .firstthird!),
//                                     Container(
//                                       alignment: Alignment.center,
//                                       height: ScreenUtil().screenHeight / 9,
//                                       margin: EdgeInsets.only(
//                                           left: 16.w,
//                                           right: 16.w,
//                                           bottom: 10,
//                                           top: ScreenUtil().screenHeight / 7),
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 5.h, horizontal: 7),
//                                       decoration: BoxDecoration(
//                                           color: AppColors.white.withOpacity(0.4),
//                                           borderRadius:
//                                               BorderRadius.circular(17)),
//                                       child: Row(
//                                         children: [
//                                           ...List.generate(
//                                             5,
//                                             (index) => Expanded(
//                                               child: Container(
//                                                 margin:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 7,
//                                                         vertical: 3),
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 7,
//                                                         vertical: 3),
//                                                 decoration: BoxDecoration(
//                                                     color: AppColors.white,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             17)),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceEvenly,
//                                                   children: [
//                                                     Icon(prayerIcon[index]),
//                                                     Text10(
//                                                         text: prayerName[index]),
//                                                     Text10(
//                                                         text: prayerTimesList[
//                                                             index])
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 16.w, right: 16.w, top: 15.h),
//                                 child: SingleChildScrollView(
//                                   physics: const BouncingScrollPhysics(),
//                                   child: Column(
//                                     children: [
//                                       Visibility(
//                                         visible:GlobalFunctions.isAuth(),
//                                         child: Column(
//                                           children: [
//                                             CustomButton(
//                                               backgroundColor: AppColors.error,
//                                               onPressed: () {
//                                                 controller.sendMessage();
//                                               },
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Iconsax.alarm5,
//                                                     color: AppColors.white,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 5.w,
//                                                   ),
//                                                   Text14(
//                                                     text: "الطوارئ",
//                                                     isBold: true,
//                                                     color: AppColors.white,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 const Text16(
//                                                   text: "تذكير الدواء",
//                                                   isBold: true,
//                                                 ),
//                                                 CustomButton(
//                                                     backgroundColor:
//                                                         AppColors.containerGrey,
//                                                     height: 50.h,
//                                                     child: const Text12(
//                                                       text: "أضف تذكير",
//                                                       textAlign: TextAlign.center,
//                                                     ),
//                                                     onPressed: () {
//                                                       Navigator.of(context).pushNamed(
//                                                           AppRoutesPath
//                                                               .medicinereminderRoute);
//                                                     })
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             GlobalFunctions.isAuth()
//                                                 ? BlocBuilder<MedicinReminderBloc,
//                                                     MedicinReminderState>(
//                                                     builder: (context, state) {
//                                                       return CustomButton(
//                                                         backgroundColor:
//                                                             AppColors.error,
//                                                         isFillColor: false,
//                                                         onPressed: () {},
//                                                         borderColor: AppColors.primary,
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment.start,
//                                                           children: [
//                                                             Icon(
//                                                               Iconsax.health,
//                                                               color: AppColors.primary,
//                                                             ),
//                                                             SizedBox(
//                                                               width: 5.w,
//                                                             ),
//                                                             Text12(
//                                                               text: state.allMedicinsStatus ==
//                                                                       AllMedicinsStatus
//                                                                           .load
//                                                                   ? "موعدك القادم:  ....."
//                                                                   : state.allMedicinsStatus ==
//                                                                           AllMedicinsStatus
//                                                                               .fail
//                                                                       ? "موعدك القادم:   يوجد خطأ ما"
//                                                                       : state.medicinsList
//                                                                               .isEmpty
//                                                                           ? "...."
//                                                                           : "موعدك القادم:   ${state.medicinsList[0].medicine?.schedule?.times?[0]}  ${state.medicinsList[0].medicine?.schedule?.date}",
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       );
//                                                     },
//                                                   )
//                                                 : Container(),
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text16(
//                                             text: "اختصارات سريعة",
//                                             isBold: true,
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 10.h,
//                                       ),
//                                       Row(
//                                         children: [
//                                           CustomHomeButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pushNamed(AppRoutesPath.recordedSupplicationsRoute);
//                                               },
//                                               icon: Icon(
//                                                 Iconsax.message_text5,
//                                                 color: AppColors.white,
//                                                 size: 15,
//                                               ),
//                                               title: "أدعية و أذكار"),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           CustomHomeButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pushNamed(AppRoutesPath.myCampingRoute);
//                                               },
//                                               icon: Icon(
//                                                 Iconsax.flag5,
//                                                 color: AppColors.white,
//                                                 size: 15,
//                                               ),
//                                               title: "الحملة")
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 10.h,
//                                       ),
//                                       Row(
//                                         children: [
//                                           CustomHomeButton(
//                                               onPressed: () {
//                                                    Navigator.of(context).pushNamed(AppRoutesPath.Al_ArqamRitualsRoute);
//                                               },
//                                               icon: Image.asset(
//                                                 AppImages.kaaba,
//                                                 height: 15.h,
//                                                 color: AppColors.white,
//                                               ),
//                                               title: "hajj_rituals_title".tr),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           CustomHomeButton(
//                                               onPressed: () {
//                                                    Navigator.of(context).pushNamed(AppRoutesPath.AmraaRitualsScreen);
//                                               },
//                                               icon: Image.asset(
//                                                 AppImages.kaaba,
//                                                 height: 15.h,
//                                                 color: AppColors.white,
//                                               ),
//                                               title:'rituals_of_umrah'.tr,)
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 10.h,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           const Text16(
//                                             text: "سؤال وفتوى",
//                                             isBold: true,
//                                           ),
//                                           CustomButton(
//                                               backgroundColor:
//                                                   AppColors.containerGrey,
//                                               height: 50.h,
//                                               child: const Text12(
//                                                 text: "عرض المزيد",
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.of(context).pushNamed(
//                                                     AppRoutesPath
//                                                         .askCampingMufti);
//                                               })
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 10.h,
//                                       ),
                                      
//                                           // if (state.getQuestionsStatus ==
//                                           //     GetQuestionsStatus.load) {
//                                           //   return GlobalFunctions.showLoading(
//                                           //       AppColors.primary);
//                                           // }
//                                           // if (state.getQuestionsStatus ==
//                                           //     GetQuestionsStatus.fail) {
//                                           //   return Text14(text: state.message);
//                                           // }
                                         
//                                              Container(
//                                               padding: const EdgeInsets.all(10),
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                 color: AppColors.primary,
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                               ),
//                                               child: Column(
//                                                 children: [
//                                                   Container(
//                                                     width: double.infinity,
//                                                     padding:
//                                                         const EdgeInsets.all(15),
//                                                     decoration: BoxDecoration(
//                                                       color: AppColors.white,
//                                                       borderRadius:
//                                                           const BorderRadius.only(
//                                                               topLeft:
//                                                                   Radius.circular(
//                                                                       25),
//                                                               topRight:
//                                                                   Radius.circular(
//                                                                       25),
//                                                               bottomRight:
//                                                                   Radius.circular(
//                                                                       25)),
//                                                     ),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         const Text14(
//                                                             textAlign:
//                                                                 TextAlign.start,
//                                                             text: "السؤال:\n"),
//                                                         AutoSizeText(
//                                                           maxLines: 2,
//                                                             controllerAsk.inquiriesResponse.value.inquiries.isEmpty?"":
//                                                                   controllerAsk.inquiriesResponse.value.inquiries[0].question!,
//                                                           softWrap: true,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style: Theme.of(context)
//                                                               .textTheme
//                                                               .bodyMedium!
//                                                               .copyWith(
//                                                                   fontSize:
//                                                                       14.sp),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     padding:
//                                                         const EdgeInsets.all(15),
//                                                     width: double.infinity,
//                                                     margin: EdgeInsets.only(
//                                                         top: 10.h),
//                                                     decoration: BoxDecoration(
//                                                       color: AppColors.white,
//                                                       borderRadius:
//                                                           const BorderRadius.only(
//                                                               topLeft:
//                                                                   Radius.circular(
//                                                                       25),
//                                                               topRight:
//                                                                   Radius.circular(
//                                                                       25),
//                                                               bottomLeft:
//                                                                   Radius.circular(
//                                                                       25)),
//                                                     ),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         const Text14(
//                                                             textAlign:
//                                                                 TextAlign.start,
//                                                             text: "الجواب:\n"),
//                                                         AutoSizeText(
//                                                           maxLines: 2,
//                                                           controllerAsk.inquiriesResponse.value.inquiries.isEmpty?"":
//                                                                   controllerAsk.inquiriesResponse.value.inquiries[0].answer!,
//                                                           softWrap: true,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style: Theme.of(context)
//                                                               .textTheme
//                                                               .bodyMedium!
//                                                               .copyWith(
//                                                                   fontSize:
//                                                                       14.sp),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
                                         
                                         
                                        
                                        
                                     
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       ),
//     );
//   }
// }
