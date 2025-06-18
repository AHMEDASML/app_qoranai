import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MistakesBetweenSafaAndMarwahWidget extends StatelessWidget {
  const MistakesBetweenSafaAndMarwahWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCommonMistakesText(),
        ],
      ),
    );
  }

  Widget _buildCommonMistakesText() {
    return GetBuilder<MainController>(
      builder: (controller) {
        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: controller.fontSize.value+2.sp,
              color: AppColors.black,
              fontFamily: 'NotoKufiArabic',
            ),
            children: [
              TextSpan(
      text: 'common_mistakes_title'.tr+"\n",
      style: TextStyle(
        fontSize: controller.fontSize.value+8.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    ),
              ..._buildMistakesList(),
            ],
          ),
        );
      }
    );
  }

  
  List<InlineSpan> _buildMistakesList() {
    final mistakes = [
      'common_mistake_1'.tr,
      'common_mistake_2'.tr,
      
     'common_mistake_verse',
        
      'common_mistake_3'.tr,
    
      'common_mistake_4'.tr,
      'common_mistake_5'.tr
    ];

    return mistakes.map((mistake) => TextSpan(
      text: '${mistake.tr}'+'\n\n',
      style:  TextStyle(color:mistake=="common_mistake_verse"?Colors.red[800]: Colors.black),
    )).toList();
  }
}