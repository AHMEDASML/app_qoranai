import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
 
  final Color backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final bool? isFillColor;

  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.width,
    
    this.height = 70.0,
    this.backgroundColor = const Color(0xffC39446),
    this.borderRadius = 50.0,
    this.isFillColor = true,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.w,
      height: height?.h,
      child: ElevatedButton(
        
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isFillColor! ? backgroundColor : AppColors.whiteBackground,
          shape: RoundedRectangleBorder(
            side: !isFillColor!
                ? BorderSide(color: borderColor ?? AppColors.black)
                : const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: child, // هنا نمرر الـ child بدلاً من النص
      ),
    );
  }
}
