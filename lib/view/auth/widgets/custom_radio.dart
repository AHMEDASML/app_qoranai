import 'package:Al_Arqam/core/resources/text/text10.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/text/text12.dart';

class LegalStatusOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final String groupValue;
  final String value;
  final void Function(String?)? onChanged;
  const LegalStatusOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.groupValue,
    this.onChanged, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      // width:90.w,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secoundaryBackground : Colors.transparent,
        borderRadius: BorderRadius.circular(30.sp),
        border: Border.all(
          color: isSelected ? Colors.transparent : AppColors.textSecoundary,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.w,
              child: Transform.scale(
                scale: 0.75,
                child: Radio(
                  value: value,
                  groupValue: groupValue,
                  activeColor: AppColors.black,
                  onChanged: onChanged,
                ),
              ),
            ),
            Text10(
              text: label,
              
              color: isSelected ? AppColors.black : AppColors.textSecoundary,
            ),
          ],
        ),
      ),
    );
  }
}
