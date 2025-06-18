import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';

// ignore: must_be_immutable
class PilgrimageScreen extends StatelessWidget {
  String description;
  PilgrimageScreen({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildContainer(desc: description.tr),
        ],
      ),
    );
  }

  Widget _buildContainer({required String desc}) {
    return GetBuilder<MainController>(builder: (controller) {
      return Container(
        width: 400.w,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.containerGrey,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc,
              style: TextStyle(
                  fontSize:
                      Get.find<MainController>().fontSize.value.sp + 1.sp),
            ),
          ],
        ),
      );
    });
  }
}
