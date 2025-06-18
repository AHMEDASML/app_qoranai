import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/app/general_widgets/custom_button.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/text/text14.dart';

class CustomHomeButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final void Function() onPressed;
  const CustomHomeButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomButton(
          borderRadius: 20,
          onPressed: onPressed,
          
          child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                icon,
                SizedBox(
                  width: 5.w,
                ),
                Text12(
                  text: title,
                  color: AppColors.white,
                )
              ],
            ),
            // SizedBox(width:5.w),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.white,
              size: 15,
            )
          ])),
    );
  }
}
