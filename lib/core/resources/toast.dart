import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';

class Toast {
  Toast._();

  // Since fluttertoast doesn't support loading spinners, we remove loading-related methods
  static void showText({required String text}) {
    Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.textSecoundary.withOpacity(0.8),     
      textColor: AppColors.white,
      fontSize: 18.sp,
    );
  }
}
