import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? isSelctedField;
  final bool? isFilled;
  List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? textInputType;
EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final double? borderRaduis;
   CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText,
    this.prefix,
    this.inputFormatters,
    this.contentPadding,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.isSelctedField = true,
    this.onChanged,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.isFilled = true,
    this.maxLines,
    this.borderRaduis,
  });

  @override
  Widget build(BuildContext context) {
    return obscureText == null
        ? TextFormField(
            maxLines: maxLines, // ✅ يتمدد حسب النص
            keyboardType: textInputType,
            onTap: onTap,
            inputFormatters:inputFormatters?? [],
            onChanged: onChanged,
            readOnly: !isSelctedField!,
            controller: controller,
            obscureText: obscureText ?? false,
            validator: validator,
            
            style:TextStyle(
                 fontSize: 14.sp,
                  color: AppColors.textSecoundary,
                    fontFamily: "NotoKufiArabic",),
            decoration: InputDecoration(
              hintText: hintText,
              
              hintStyle: TextStyle(
                 fontSize: 13.sp,
                  color: AppColors.textSecoundary,
                    fontFamily: "NotoKufiArabic",),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              prefix: prefix,
              filled: true,
              fillColor: isFilled!
                  ? isSelctedField!
                      ? AppColors.secoundaryBackground
                      : AppColors.containerGrey
                  : AppColors.containerGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    borderRaduis ?? 100), // نصف قطر دائري بمقدار 100px
                borderSide: BorderSide.none, // إزالة الإطار
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    borderRaduis ?? 100), // نصف قطر دائري عند التفعيل
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    borderRaduis ?? 100), // نصف قطر دائري عند التركيز
                borderSide: BorderSide.none, // لون الإطار عند التركيز
              ),
              errorStyle: TextStyle(
  fontSize: 11.sp,
  color: Colors.red, // or AppColors.errorColor if defined
  fontFamily: "NotoKufiArabic",
),
              contentPadding:contentPadding??
                  EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
            ),
          )
        : TextFormField(
            keyboardType: textInputType,
            onTap: onTap,
            onChanged: onChanged,
            readOnly: !isSelctedField!,
            controller: controller,
            obscureText: obscureText ?? false,
            validator: validator,
            
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecoundary,
                    fontFamily: "NotoKufiArabic",
                  ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              prefix: prefix,
              filled: true,
              fillColor: isFilled!
                  ? isSelctedField!
                      ? AppColors.secoundaryBackground
                      : AppColors.containerGrey
                  : AppColors.containerGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    borderRaduis ?? 100), // نصف قطر دائري بمقدار 100px
                borderSide: BorderSide.none, // إزالة الإطار
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    borderRaduis ?? 100), // نصف قطر دائري عند التفعيل
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    borderRaduis ?? 100), // نصف قطر دائري عند التركيز
                borderSide: BorderSide.none, // لون الإطار عند التركيز
              ),
              errorStyle: TextStyle(
  fontSize: 11.sp,
  color: Colors.red, // or AppColors.errorColor if defined
  fontFamily: "NotoKufiArabic",
),
              contentPadding:contentPadding??
                  EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w),
            ),
          );
  }
}
