import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_text_form.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/ask_camping_mufti/controller/ask_camping_mufti_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/view/main_controller.dart';

class CustomSendQuestionMufti extends StatefulWidget {
  final double initialFontSize;
  final Function(double) onFontSizeChanged;

  const CustomSendQuestionMufti({
    super.key,
    required this.initialFontSize,
    required this.onFontSizeChanged,
  });

  @override
  _FontSizeDialogState createState() => _FontSizeDialogState();
}

class _FontSizeDialogState extends State<CustomSendQuestionMufti> {
  late double fontSize;

  @override
  void initState() {
    super.initState();
    fontSize = widget.initialFontSize;
  }

  AskCampingMuftiController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AskCampingMuftiController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: AlertDialog(
            backgroundColor: AppColors.white,
            contentPadding: EdgeInsets.only(top: 10.h),
            buttonPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.only(right: 20.w, top: 20.h),
            iconPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            content: Container(
              height: 400.h,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),
                  Container(
                    height: 200.h,
                    child: CustomTextField(
                      contentPadding: EdgeInsets.only(top: 5.h, bottom: 5.w, right: 10.w, left: 10.w),
                      borderRaduis: 20.r,
                      maxLines: 10,
                      isFilled: false,
                      controller: controller.inqueryDetails,
                      hintText: 'ask_here'.tr,
                      prefixIcon: null,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                    child: CustomButton(
                      height: 90.h,
                      onPressed: () {
                        controller.addInquiries(context);
                      },
                      borderRadius: 20.r,
                      backgroundColor: AppColors.primary,
                      child: controller.isLoadingAdd.value
                          ? Center(child: GlobalFunctions.showLoading(AppColors.white, size: 16.sp))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text14(
                                  text: 'send_to_mufti'.tr,
                                  color: AppColors.white,
                                  isBold: true,
                                ),
                              ],
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                    child: CustomButton(
                      height: 90.h,
                      onPressed: () {
                        Get.back();
                      },
                      borderRadius: 20.r,
                      borderColor: AppColors.primary,
                      isFillColor: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text14(
                            text: 'cancel'.tr,
                            color: AppColors.primary,
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void showCustomSendQuestionMufti(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomSendQuestionMufti(
        initialFontSize: Get.find<MainController>().fontSize.value,
        onFontSizeChanged: (newFontSize) {
          Get.find<MainController>().fontSize.value = newFontSize;
          Get.find<MainController>().update();
        },
      );
    },
  );
}