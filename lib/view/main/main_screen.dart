import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/ask_camping_mufti/controller/ask_camping_mufti_controller.dart';
import 'package:Al_Arqam/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/view/Map/controller/map_controller.dart';
import 'package:Al_Arqam/view/Map/map_screen.dart';
import 'package:Al_Arqam/view/Map/widgets/resturant_card_widget.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:Al_Arqam/view/my_account/my_account_screen.dart';
import 'package:Al_Arqam/view/quran/chapters_page.dart';
import 'package:iconsax/iconsax.dart';

import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text10.dart';
import 'package:Al_Arqam/view/home/home_screen.dart';
import 'package:Al_Arqam/view/medicine_reminder/medicine_reminder_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  String? currentPage;
  MainScreen({
    super.key,
    this.currentPage,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isNavBarVisible = true;
  AskCampingMuftiController controllerAsk=Get.put(AskCampingMuftiController());
  final List<String> titles = [
    "home",
    "guide_me",
    "quran",
    "health",
    "my_account"
  ];

  final List<Widget> screen = [
    const HomeView(),
    const CustomGoogleMap(),
    const ChaptersScreen(),
    const MedicineReminderScreen(),
    MyAccountScreen()
  ];

  final List<IconData> icons = [
    Iconsax.home_2,
    Iconsax.map,
    Iconsax.book_square,
    Iconsax.health,
    Iconsax.profile_circle,
  ];

  void _onItemTapped(int index) {
    if(index==1 && GlobalFunctions.isAuth())
    { controller.showMap.value=true;}
    else{
      controller.showMap.value=false;
    }
    setState(() {

      _selectedIndex = index;
    });
  }

  bool isSelected(int index) => _selectedIndex == index;

  void _onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        if (_isNavBarVisible) {
          setState(() {
            _isNavBarVisible = false;
          });
        }
      } else if (notification.direction == ScrollDirection.forward) {
        if (!_isNavBarVisible) {
          setState(() {
            _isNavBarVisible = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    _selectedIndex = widget.currentPage == AppRoutesPath.homeRoute
        ? 0
        : widget.currentPage == AppRoutesPath.CustomGoogleMap
        ? 1
        : widget.currentPage == AppRoutesPath.quranRoute
        ? 2
        : widget.currentPage == AppRoutesPath.medicinereminderRoute
        ? 3
        : widget.currentPage == AppRoutesPath.profileRoute
        ? 4
        : 0;
    super.initState();
  }
  MainController controller=Get.find<MainController>();
  final MapController controllerCamp = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar:true,
            body: Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    _onScroll(notification);
                    return true;
                  },
                  child: screen[_selectedIndex],
                ),
                Visibility(
                  visible: !controller.showMap.value&&!controller.showLocation.value&&!controller.showRestaurantInfo.value,
                  child: Positioned(
                    bottom: 10.h,
                    left: 15,
                    right: 15,
                    child: AnimatedSlide(
                      offset: _isNavBarVisible ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(titles.length, (index) {
                                return InkWell(
                                  onTap: () => _onItemTapped(index),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    padding: EdgeInsets.symmetric(
                                        vertical: isSelected(index) ? 8 : 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AnimatedOpacity(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          opacity: isSelected(index) ? 1.0 : 0.6,
                                          child: Icon(
                                            icons[index],
                                            size: 30.h,
                                            color: isSelected(index)
                                                ? AppColors.primary
                                                : AppColors.textNavBar,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text10(
                                          text: titles[index].tr,
                                          color: isSelected(index)
                                              ? AppColors.primary
                                              : AppColors.textNavBar,
                                          isBold: isSelected(index),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.showMap.value&&!controller.showLocation.value,
                  child: Positioned(
                    bottom: 0.h,
                    left: 2,
                    right: 2,
                    child: AnimatedSlide(
                      offset: _isNavBarVisible ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        // width: 400.w,
                        padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [



                                InkWell(
                                  onTap: () async {
                                    // طلب صلاحيات الموقع مع واجهة المستخدم
                                    await _requestLocationWithUI();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 15.h, horizontal: 0.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.h, horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.containerGrey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Obx(() => controller.isLocationLoading.value
                                        ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                        strokeWidth: 2,
                                      ),
                                    )
                                        : Icon(
                                      Icons.location_pin,
                                      color: controller.isLocationPermissionGranted.value
                                          ? AppColors.primary
                                          : AppColors.textSecoundary,
                                      size: 20.0,
                                    ),
                                    ),
                                  ),
                                ),






                                SizedBox(width: 15.w),
                                InkWell(
                                  onTap:(){
                                    controller.showLocation.value=true;
                                    controller.update();
                                  },
                                  child: Container(
                                      width: Get.width-95.w,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 4.w),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 16.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.containerGrey,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child:  Center(child: Text("start_navigation".tr))),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 14.w),
                              decoration: BoxDecoration(
                                color: AppColors.containerGrey,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(titles.length, (index) {
                                  return InkWell(
                                    onTap: () => _onItemTapped(index),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      padding: EdgeInsets.symmetric(
                                          vertical: isSelected(index) ? 8 : 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedOpacity(
                                            duration:
                                            const Duration(milliseconds: 300),
                                            opacity: isSelected(index) ? 1.0 : 0.6,
                                            child: Icon(
                                              icons[index],
                                              size: 30.h,
                                              color: isSelected(index)
                                                  ? AppColors.primary
                                                  : AppColors.textNavBar,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text10(
                                            text: titles[index].tr,
                                            color: isSelected(index)
                                                ? AppColors.primary
                                                : AppColors.textNavBar,
                                            isBold: isSelected(index),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.showCamping.value,
                  child: Positioned(
                    bottom: 0.h,
                    left: 2,
                    right: 2,
                    child: AnimatedSlide(
                      offset: _isNavBarVisible ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        // width: 400.w,

                        padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First Container: مواقع الحملة
                            InkWell(
                              onTap:() {
                                //  controller.fetchCampaign();
                                //                            mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(
                                // double.parse(currentPosition.split(" ")[0]),
                                // double.parse(currentPosition.split(" ")[1]))));
                                // controllerCamp.uploadLocationPlaces();

                              },
                              child: Container(
                                width: 400.w,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 4.w),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(bottom:  10.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'campaign_locations'.tr,
                                            style: TextStyle(color: Colors.black, fontSize: 16),
                                          ),
                                          InkWell(
                                            onTap:(){
                                              controller.showRestaurantInfo.value=false;
                                              controller.showLocation.value=false;
                                              controller.showMap.value=true;
                                              controller.showCamping.value=false;
                                              controller.markers.clear();
                                              controller.update();

                                            },
                                            child: Image.asset(
                                              'assets/images/filter.png', // Replace with your asset image path
                                              fit: BoxFit.cover, // Fit the image within the container
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ..._buildLocation()
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: controller.showLocation.value,
                  child: Positioned(
                    bottom: 0.h,
                    left: 2,
                    right: 2,
                    child: AnimatedSlide(
                      offset: _isNavBarVisible ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        // width: 400.w,

                        padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First Container: مواقع الحملة
                            InkWell(
                              onTap:() {
                                controller.showCamping.value=true;
                                controller.showMap.value=false;
                                controller.showLocation.value=false;
                                controller.update();
                                //  controller.fetchCampaign();
                                //                            mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(
                                // double.parse(currentPosition.split(" ")[0]),
                                // double.parse(currentPosition.split(" ")[1]))));
                                // controllerCamp.uploadLocationPlaces();

                              },
                              child: Container(
                                width: 400.w,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 4.w),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: AppColors.containerGrey,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'campaign_locations'.tr,
                                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                                    ),
                                    // ..._buildLocation()
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),

                            // Second Container: المطاعم القريبة
                            InkWell(
                              onTap:(){
                                controller.updateLocation();
                                controller.showMap.value=true;
                                controller.showLocation.value=false;
                                controller.showRestaurantInfo.value=false;
                                controller.update();
                              },
                              child: Container(
                                width: 400.w,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 4.w),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 16.w),
                                decoration: BoxDecoration(
                                  color: AppColors.containerGrey,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child:  Text(
                                  'nearby_restaurants'.tr,
                                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),

                            // Third Container: Column with list of locations
                            Container(
                              width: 400.w,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 4.w),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: AppColors.containerGrey,
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'sacred_places'.tr,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                  ),
                                  // Container(height:2.h,color: AppColors.greyVerfication,),
                                  const SizedBox(height: 8),
                                  // List of locations
                                  ..._buildLocationList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),



                const ResturantCardWidget()
              ],
            ),
          );
        }
    );
  }

  List<Widget> _buildLocationList() {
    // List of locations
    final List<String> locations = [
      'kaaba',
      'mount_arafat',
      'mina',
      'grand_mosque',
      'prophet_mosque',
      'cave_hira',
      'cave_thor',
      'namira_mosque',
    ];

    // Create a list of Text widgets for each location
    return locations
        .map((location) => InkWell(
      onTap:(){
        controller.showMap.value=true;
        controller.showLocation.value=false;
        controller.isLoading.value=false;
        controller.update();
        controller.getLatLongByName(location);
        //    controller.showLocation.value=false;
        //  controller.showMap.value=true;
        // controller.update();

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              location.tr,
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            Container(
              height: 0.5.h,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    ))
        .toList();
  }
  List<Widget> _buildLocation() {
    // List of locations
    // final List<String> locations = [
    //   'الكعبة المشرفة',
    //   'جبل عرفات',
    //   'منى',
    //   'المسجد الحرام',
    //   'المسجد النبوي',
    //   'غار حراء',
    //   'غار ثور',
    //   'مسجد نمرة',
    // ];

    // Create a list of Text widgets for each location
    return controller.campaign.value.campaign!=null?


    controller.campaign.value.campaign!.guide
        .map((location) => InkWell(
      onTap:(){
        controller.uploadLocationPlaces(location.title);
        // controller.showMap.value=true;
        // controller.showLocation.value=false;
        // controller.update();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.spaa,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween ,
              children: [
                Text(
                  location.title,
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
                Text(
                  '${location.mobile!.number} ${location.mobile!.prefix!.substring(1,4)}+',
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
              ],
            ),
            Container(
              height: 0.5.h,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    ))
        .toList():[];
  }

  Future<void> _requestLocationWithUI() async {
    try {
      // Mostrar indicador de carga
      controller.isLocationLoading.value = true;

      // Verificar si ya tenemos permisos
      if (controller.isLocationPermissionGranted.value) {
        // Permisos concedidos - actualizar ubicación directamente
        await controller.getCurrentLocationAndUpdateMap();

        // Mostrar el mapa y centrar en la ubicación actual
        controller.showMap.value = true;
        controller.showLocation.value = false;
        controller.showRestaurantInfo.value = false;

        // Actualizar la interfaz
        controller.update();

        // Mostrar mensaje de éxito
        Get.snackbar(
          'location_success'.tr,
          'location_updated_successfully'.tr,
          backgroundColor: AppColors.green.withOpacity(0.8),
          colorText: AppColors.white,
          icon: Icon(Icons.check_circle, color: AppColors.white),
          duration: Duration(seconds: 2),
        );
      } else {
        // Solicitar permisos con UI
        bool granted = await controller.requestLocationPermissionsWithUI(context);

        if (granted) {
          // Permisos concedidos - obtener ubicación y actualizar mapa
          await controller.getCurrentLocationAndUpdateMap();

          // Mostrar el mapa y centrar en la ubicación actual
          controller.showMap.value = true;
          controller.showLocation.value = false;
          controller.showRestaurantInfo.value = false;

          // Actualizar la interfaz
          controller.update();

          // Mostrar mensaje de éxito
          Get.snackbar(
            'location_success'.tr,
            'location_updated_successfully'.tr,
            backgroundColor: AppColors.green.withOpacity(0.8),
            colorText: AppColors.white,
            icon: Icon(Icons.check_circle, color: AppColors.white),
            duration: Duration(seconds: 2),
          );
        } else {
          // Permisos denegados - mostrar mensaje
          Get.snackbar(
            'location_permission_required'.tr,
            'location_permission_needed_message'.tr,
            backgroundColor: AppColors.error.withOpacity(0.8),
            colorText: AppColors.white,
            icon: Icon(Icons.warning, color: AppColors.white),
            duration: Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      print('❌ Error al solicitar ubicación: $e');

      // Mostrar mensaje de error
      Get.snackbar(
        'location_error'.tr,
        'failed_to_get_location'.tr,
        backgroundColor: AppColors.error.withOpacity(0.8),
        colorText: AppColors.white,
        icon: Icon(Icons.error, color: AppColors.white),
        duration: Duration(seconds: 3),
      );
    } finally {
      // Ocultar indicador de carga
      controller.isLocationLoading.value = false;
    }
  }
}