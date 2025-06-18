import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MistakesMaqamIbrahemWidget extends StatelessWidget {
  const MistakesMaqamIbrahemWidget({Key? key}) : super(key: key);

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
                  text: 'emphasis_on_rakats'.tr,
                  // style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}