import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextThrowingTheJamratWidget extends StatelessWidget {
  const TextThrowingTheJamratWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: controller.fontSize.value+2.sp,
                color: AppColors.black,
                fontFamily: 'NotoKufiArabic',
              ),
              children: [
                 TextSpan(
                  text: 'throwing_jamrat_al_aqabah'.tr + '\n\n',
                  style: TextStyle(
                    fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                TextSpan(
                  text: 'stoning_intro'.tr + '\n\n',
                  // style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'stoning_collect_pebbles'.tr + '\n\n',
                ),
                TextSpan(
                  text: 'stoning_reach_jamarat'.tr + '\n\n',
                ),
                TextSpan(
                  text: 'stoning_stop_talbiyah'.tr + '\n\n',
                ),
                TextSpan(
                  text: 'stoning_throw_pebbles'.tr + '\n\n',
                ),
                TextSpan(
                  text: 'stoning_pebble_in_basin'.tr + '\n\n',
                ),
                TextSpan(
                  text: 'stoning_start_takbeer'.tr + '\n\n',
                ),
                TextSpan(
                  text: 'takbeer'.tr + '\n',
                  style: TextStyle(color: Colors.red[800]),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}