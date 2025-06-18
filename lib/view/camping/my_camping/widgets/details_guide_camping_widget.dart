import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_empty.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_reload.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/camping/controller/my_camping_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsGuideCampingWidget extends StatefulWidget {
  const DetailsGuideCampingWidget({super.key});

  @override
  State<DetailsGuideCampingWidget> createState() =>
      _DetailsGuideCampingWidgetState();
}

class _DetailsGuideCampingWidgetState
    extends State<DetailsGuideCampingWidget> {
  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<MyCampingController>(builder: (controller) {
         print('ggg${controller.campaign.value.campaign}');
      return GetBuilder<MainController>(builder: (context) {
        return  !controller.isLoading.value
            ?  controller.errorMainMessage.isNotEmpty?
                                     Padding(
                                       padding:  EdgeInsets.only(top:250.h),
                                       child: ErrorReloadWidget(onRetry:(){
                                        controller.fetchCampaign();
                                       },),
                                     ):
                                     
                                      controller.campaign.value.campaign!.guide.isEmpty?
                                    Padding(
                                      padding:  EdgeInsets.only(top:200.h),
                                      child: EmptyLottieWidget(),
                                    )
                                    :
            
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                   Text14(
                    text: 'support_section'.tr,
                    isBold: true,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 300.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.campaign.value.campaign!.guide.length,
                      itemBuilder: (context, index) {
                        final guide = controller.campaign.value.campaign!.guide[index];
                        return Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.currentPosition.value =
                                      "${guide.location!.coordinates![0]} ${guide.location!.coordinates![1]}";
                                  controller.markers.clear();
                                  controller.markers.add(
                                    Marker(
                                      onTap: controller.onMarkerTapped,
                                      markerId: MarkerId(guide.title),
                                      position: LatLng(
                                        guide.location!.coordinates![0],
                                        guide.location!.coordinates![1],
                                      ),
                                    ),
                                  );
                                  controller.changePosition();
                                  controller.update();
                                },
                                child: Text(
                                  guide.title,

                                  style: TextStyle(fontSize: 14.sp,fontFamily:"NotoKufiArabic", fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              CustomButton(
                                height: 90.h,
                                onPressed: () {
                                  controller.launchWhatsApp("+${guide.mobile!.prefix.toString().substring(1, 4)}${guide.mobile!.number}");
                                },
                                borderRadius: 20.r,
                                backgroundColor: AppColors.green,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Text14(
                                        text: "${guide.mobile!.prefix.toString().substring(1, 4)}${guide.mobile!.number}+",
                                        color: AppColors.white,
                                        isBold: true,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/whatsapp.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                   Text14(
                    text: 'campaign_locations'.tr,
                    isBold: true,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: SizedBox(
                      height: 275.h,
                      child: GoogleMap(
                        scrollGesturesEnabled: true,
                        markers: controller.markers,
                        initialCameraPosition: CameraPosition(
                          target: controller.currentPosition.isEmpty
                              ? const LatLng(21.4225, 39.8262)
                              : LatLng(
                                  double.parse(controller.currentPosition.split(" ")[0]),
                                  double.parse(controller.currentPosition.split(" ")[1]),
                                ),
                          zoom: 12.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onMapCreated: (GoogleMapController mapController) {
                          controller.mapController = mapController;
                          controller.mapController!.setMapStyle(controller.mapStyle);
                        },
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 150.h),
                  child: Center(
                    child: GlobalFunctions.showLoading(AppColors.primary, size: 18.sp),
                  ),
                ),
              );
      });
    });
  }
}