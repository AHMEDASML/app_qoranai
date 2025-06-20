import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';

class Text32 extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isBold;
  final TextAlign? textAlign;
  const Text32(
      {super.key,
      required this.text,
      this.color,
      this.isBold = false,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 32.sp,
          fontFamily: "NotoKufiArabic",
          color: color ?? AppColors.black,
          fontWeight: isBold ? FontWeight.w500 : FontWeight.w400),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
