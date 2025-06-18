import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTap extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
   double? width;
  final void Function() onTap;
   CustomTap(
      {super.key,
      required this.color,
      required this.text,
      this.width,
      required this.textColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 65.h,
        width:width?? 183.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(25.r)),
        child: Text12(
          text: text,
          color: textColor,
          isBold: true,
        ),
      ),
    );
  }
}
