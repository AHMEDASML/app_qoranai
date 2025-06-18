import 'package:Al_Arqam/core/app/general_widgets/custom_empty.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_reload.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/camping/controller/my_camping_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ListProgramCampingWidget extends StatelessWidget {
  MainController controller = Get.find();
  MyCampingController controllerCamping = Get.find();
  
  ListProgramCampingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      print('ggg${controller.campaign.value}');
      return !controller.isLoading.value
          ?  controller.errorMainMessage.isNotEmpty?
                                     Padding(
                                        padding:  EdgeInsets.only(top:250.h),
                                       child: ErrorReloadWidget(onRetry:(){
                                        controller.fetchCampaign();
                                       },),
                                     ):
                                     
                                      controller.campaign.value.campaign!.program.isEmpty?
                                    Padding(
                                      padding:  EdgeInsets.only(top:200.h),
                                      child: EmptyLottieWidget(),
                                    )
                                    :
           ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: controller.campaign.value.campaign!.program.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    controllerCamping.selectedProgram = controller.campaign.value.campaign!.program[index];
                    controllerCamping.campinAppBar = controller.campaign.value.campaign!.program[index].title;
                    controller.currentPosition.value = 
                      "${controller.campaign.value.campaign!.program[index].location!.coordinates![0]} ${controller.campaign.value.campaign!.program[index].location!.coordinates![1]}";
                    controller.markers.clear();
                    controller.markers.add(
                      Marker(
                        onTap: controller.onMarkerTapped,
                        markerId: MarkerId(controller.campaign.value.campaign!.program[index].title),
                        position: LatLng(
                          controller.campaign.value.campaign!.program[index].location!.coordinates![0],
                          controller.campaign.value.campaign!.program[index].location!.coordinates![1],
                        ),
                      ),
                    );

                    controllerCamping.update();
                    controller.update();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.campaign.value.campaign!.program[index].title,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              controller.formatDate(controller.campaign.value.campaign!.program[index].date.toString()),
                              style: TextStyle(fontSize: 16.sp, color: AppColors.textSecoundary),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.arrow_forward_ios, size: 16.sp),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
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
  }
}