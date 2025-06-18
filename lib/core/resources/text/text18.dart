import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_manager.dart';


class Text18 extends StatelessWidget {
  final String text;
  final Color? color;
  final bool isBold;
  final TextAlign? textAlign;
  const Text18(
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
          fontSize: 18.sp,
          fontFamily: "NotoKufiArabic",
          color: color ?? AppColors.black,
          fontWeight:  FontWeight.bold),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
