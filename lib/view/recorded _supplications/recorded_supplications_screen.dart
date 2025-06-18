import 'package:Al_Arqam/core/app/general_widgets/custom_empty.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_reload.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/view/auth/nesseccary_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_popup_fontsize.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_type.dart';
import 'package:Al_Arqam/core/enums/recorder_supplications_enum.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:Al_Arqam/view/recorded%20_supplications/controller/recorderd_supplication_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/app/general_widgets/custom_app_bar.dart';
import '../../core/app/general_widgets/custom_tile.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/text/text14.dart';

class RecordedSupplicationsScreen extends StatefulWidget {
  const RecordedSupplicationsScreen({super.key});

  @override
  State<RecordedSupplicationsScreen> createState() =>
      _RecordedSupplicationsScreenState();
}

class _RecordedSupplicationsScreenState
    extends State<RecordedSupplicationsScreen> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  bool isLooping = false;
  final RecorderdSupplicationController controller =
      Get.put(RecorderdSupplicationController());
  
  Future<void> playAudio(String url) async {
    try {
      await player.setUrl(url);
      player.play();
      setState(() => isPlaying = true);
      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed && !isLooping) {
          setState(() => isPlaying = false);
        }
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Widget buildAudioPlayer() {
    return GetBuilder<RecorderdSupplicationController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Text14(
                  text: controller.selectedaudio.isEmpty
                      ? 'choose_supplication'.tr
                      : controller.selectedaudio),
            ),
            const Divider(),
            StreamBuilder<Duration>(
              stream: player.positionStream,
              builder: (context, snapshot) {
                final duration = snapshot.data ?? Duration.zero;
                final maxDuration = (player.duration ?? Duration.zero)
                    .inMilliseconds
                    .toDouble();
                final currentDuration =
                    duration.inMilliseconds.clamp(0, maxDuration).toDouble();

                return Slider(
                  min: 0.0,
                  max: maxDuration > 0 ? maxDuration : 1.0,
                  value: currentDuration,
                  onChanged: (value) {
                    player.seek(Duration(milliseconds: value.toInt()));
                    controller.valueslider = value;
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Iconsax.heart),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    player.seek(
                        Duration(seconds: player.position.inSeconds - 10));
                  },
                ),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 35.h,
                  child: IconButton(
                    icon: Icon(isPlaying ? Iconsax.pause5 : Icons.play_arrow,
                        size: 30, color: AppColors.white),
                    onPressed: () {
                      if (isPlaying) {
                        player.pause();
                      } else {
                        if (player.position.inSeconds == 0) {
                          playAudio(
                              "https://api.alarqambh.com/${controller.selectedaudio}");
                        } else {
                          player.seek(
                              Duration(seconds: player.position.inSeconds));
                          player.play();
                        }
                      }
                      setState(() => isPlaying = !isPlaying);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    player.seek(
                        Duration(seconds: player.position.inSeconds + 10));
                  },
                ),
                IconButton(
                  icon: Icon(Iconsax.repeat),
                  onPressed: () {
                    setState(() => isPlaying = true);
                    player.seek(const Duration(seconds: 0));
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(controller.errorMessage);
    return GetBuilder<RecorderdSupplicationController>(builder: (controller) {
      return  Scaffold(
              backgroundColor: AppColors.whiteBackground,
              appBar: CustomAppBar(
                title: 'recorded_supplications'.tr,
                backgroundColor: AppColors.whiteBackground,
                triling:CustomTrailing(),
              ),
              body: Padding(
                padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                child: Column(
                  children: [
                    Container(
                      height: 1.h,
                      color: AppColors.greyVerfication,
                    ),
                    SizedBox(height: 40.h),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTap(
                            width: 180.w,
                            color: controller.selectedTab.value ==
                                    RecorderSupplicationsEnum.sunnah
                                ? AppColors.primary
                                : AppColors.containerGrey,
                            text: 'from_sunnah'.tr,
                            textColor: controller.selectedTab.value ==
                                    RecorderSupplicationsEnum.sunnah
                                ? AppColors.white
                                : AppColors.textSecoundary,
                            onTap: () {
                              controller.changeTab(RecorderSupplicationsEnum.sunnah);
                              controller.update();
                            },
                          ),
                          CustomTap(
                            width: 180.w,
                            color: controller.selectedTab.value ==
                                    RecorderSupplicationsEnum.quran
                                ? AppColors.primary
                                : AppColors.containerGrey,
                            text: 'from_quran'.tr,
                            textColor: controller.selectedTab.value ==
                                    RecorderSupplicationsEnum.quran
                                ? AppColors.white
                                : AppColors.textSecoundary,
                            onTap: () {
                              controller.changeTab(RecorderSupplicationsEnum.quran);
                              controller.update();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: controller.selectedTab.value ==
                          RecorderSupplicationsEnum.quran,
                      child: GetBuilder<RecorderdSupplicationController>(
                          builder: (controller) {
                        return controller.isLoading.value
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 150.h),
                                child: Center(
                                    child: GlobalFunctions.showLoading(
                                        AppColors.primary,
                                        size: 25.sp)),
                              ): controller.errorMessage.isNotEmpty?
                                     Padding(
                                         padding: EdgeInsets.only(top: 160.h),
                                       child: ErrorReloadWidget(onRetry:(){
                                        controller.onInit();
                                       },),
                                     )
                                    
                            
                            : controller.supplications.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(top: 130.h),
                                    child: EmptyLottieWidget())
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: controller.supplications.length,
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          playAudio(
                                              "https://api.alarqambh.com/${controller.supplications[index].audio!}");
                                          controller.selectedaudio =
                                              controller.supplications[index].title!;
                                          controller.isPlayed = true;
                                          controller.update();
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 15.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.secoundaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: GetBuilder<MainController>(
                                                builder: (context) {
                                              return CustomTile(
                                                fontsize: controller.fontSize.value,
                                                title: controller
                                                    .supplications[index].title!,
                                                isExpansion: true,
                                                leading: null,
                                                answer: controller
                                                    .supplications[index].text!,
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                      }),
                    ),
                    Visibility(
                      visible: controller.selectedTab.value ==
                          RecorderSupplicationsEnum.sunnah,
                      child: GetBuilder<RecorderdSupplicationController>(
                          builder: (controller) {
                        return controller.isLoadingSunnh.value
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 150.h),
                                child: Center(
                                    child: GlobalFunctions.showLoading(
                                        AppColors.primary,
                                        size: 25.sp))
                              ): controller.errorMessage.isNotEmpty?
                                     Padding(
                                         padding: EdgeInsets.only(top: 160.h),
                                       child: ErrorReloadWidget(onRetry:(){
                                        controller.onInit();
                                       },),
                                     )
                                    
                            : controller.supplicationsSunah.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(top: 130.h),
                                    child: EmptyLottieWidget())
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: controller.supplicationsSunah.length,
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          playAudio(
                                              "https://api.alarqambh.com/${controller.supplicationsSunah[index].audio!}");
                                          controller.selectedaudio =
                                              controller.supplicationsSunah[index].title!;
                                          controller.isPlayed = true;
                                          controller.update();
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 15.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.secoundaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: GetBuilder<MainController>(
                                                builder: (context) {
                                              return CustomTile(
                                                fontsize: controller.fontSize.value,
                                                title: controller
                                                    .supplicationsSunah[index].title!,
                                                isExpansion: true,
                                                leading: null,
                                                answer: controller
                                                    .supplicationsSunah[index].text!,
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                      }),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: buildAudioPlayer(),
            );
    });
  }
}