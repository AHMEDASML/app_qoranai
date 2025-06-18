import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:get/get.dart';

class CustomDateTime extends StatelessWidget {
  final String title;
  final String data;

  const CustomDateTime({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text14(text: title.tr), // Using the translation for title
        Container(
          height: 60.w,
          width: 235.h,
          decoration: BoxDecoration(
            color: AppColors.containerGrey,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Text12(
                  text: data,
                  textAlign: TextAlign.start,
                  isBold: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}