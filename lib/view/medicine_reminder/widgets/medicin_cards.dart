import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';

import '../../../core/resources/text/text12.dart';

class CustomMedicationCard extends StatelessWidget {
  final String title;
  final String time;
  final String? description;
  final IconData icon;
  final void Function()? onTap;

  const CustomMedicationCard({
    super.key,
    required this.title,
    required this.time,
    required this.description,
    this.icon = Icons.medical_services,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 14,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Image.asset(AppImages.pill),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AutoSizeText(
                    title,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                const Icon(Icons.alarm),
                SizedBox(width: 10.w),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.containerGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text12(
                    text: time,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            if (description != null && description!.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.info_outline),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AutoSizeText(
                        description!,
                        style: TextStyle(fontSize: 12.sp),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}