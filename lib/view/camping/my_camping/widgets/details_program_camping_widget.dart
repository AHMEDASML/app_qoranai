import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/camping/controller/my_camping_controller.dart';
import 'package:Al_Arqam/view/camping/my_camping/widgets/custom_date_time.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsProgramCampingWidget extends StatefulWidget {
  const DetailsProgramCampingWidget({super.key});

  @override
  State<DetailsProgramCampingWidget> createState() => _DetailsProgramCampingWidgetState();
}

class _DetailsProgramCampingWidgetState extends State<DetailsProgramCampingWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCampingController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1.h,
              color: AppColors.greyVerfication,
            ),
            SizedBox(height: 40.h),
            SizedBox(
              height: 130.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDateTime(
                    title: 'date'.tr, // Using translation
                    data: controller.formatDate(controller.selectedProgram!.date!.toString()),
                  ),
                  CustomDateTime(
                    title: 'time'.tr, // Using translation
                    data: controller.formatTime(controller.selectedProgram!.date!),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
             Text14(
              text: 'location'.tr, // Using translation
              isBold: true,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 30.h),
            GetBuilder<MainController>(
              builder: (mainController) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: SizedBox(
                    height: 275.h,
                    child: GoogleMap(
                      scrollGesturesEnabled: true,
                      markers: mainController.markers,
                      initialCameraPosition: CameraPosition(
                        target: mainController.currentPosition.isEmpty
                            ? const LatLng(21.4225, 39.8262)
                            : LatLng(
                                double.parse(mainController.currentPosition.split(" ")[0]),
                                double.parse(mainController.currentPosition.split(" ")[1]),
                              ),
                        zoom: 12.0,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController mapController) {
                        mainController.mapController = mapController;
                        mainController.mapController!.setMapStyle(mainController.mapStyle);
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30.h),
             Text14(
              text: 'details_and_notes'.tr, // Using translation
              isBold: true,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 30.h),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Text12(
                  text: controller.selectedProgram!.details,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}