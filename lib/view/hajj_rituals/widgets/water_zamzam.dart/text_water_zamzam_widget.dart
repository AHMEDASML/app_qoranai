import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextWaterZamzamWidget extends StatelessWidget {
  const TextWaterZamzamWidget({Key? key}) : super(key: key);

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
                // ماء زمزم Title
                TextSpan(
                  text: 'water_zamzam'.tr+'\n\n',
                  style: TextStyle(
                    fontSize: controller.fontSize.value+8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                // Content
               TextSpan(
                      text: 'zamzam_instructions'.tr+'\n',
                      // style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text:'"'+'zamzam_food_cure'.tr+'"'+"\n",
                      style: TextStyle(color: Colors.red[800]),
                    ),
                    TextSpan(
                      text: 'zamzam_instructions1'.tr+'\n',
                      // style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text:'"'+'zamzam_drink_intention'.tr+'"',
                      style: TextStyle(color: Colors.red[800]),
                    ),
                   
               
                TextSpan(
                  text:"\n\n" +'zamzam_virtue_title'.tr + '\n\n',
                  style: TextStyle(
                    fontSize: controller.fontSize.value+6.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'zamzam_virtue'.tr+'\n\n',
                ),
                TextSpan(
                  text: ' ' + 'zamzam_supplication_ask'.tr+"\n",
                  style: TextStyle(color: AppColors.primary),
                ),
                TextSpan(
                  text: '\n' + 'zamzam_supplication'.tr,
                ),
                TextSpan(
                  text: ' ' + 'zamzam_drinking_method'.tr,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}