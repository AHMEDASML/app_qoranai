import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';

class CustomTextLink extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onTap;

  const CustomTextLink({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          fontSize: 15.sp,
          color: AppColors.textSecoundary, // Customize color
          fontFamily: "NotoKufiArabic",
        ),
        children: [
          TextSpan(
            text: secondText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: AppColors.textSecoundary, // Customize color
              height: 2,
              fontFamily: "NotoKufiArabic",
            ),
          ),
        ],
      ),
    );
  }
}
