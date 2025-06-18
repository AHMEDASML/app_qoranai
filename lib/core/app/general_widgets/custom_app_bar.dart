import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../resources/color_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
   CustomAppBar({
    super.key,
    required this.title,
    this.hasBackButton = true,
    this.leading,
    this.scaffoldKey,
    this.triling,
    this.isVerses=false,
    this.titleColor,
    this.onTap,
    this.vertical,
    this.subTitle,
    this.size,
    this.isManask,
    this.backgroundColor,
    this.isBackIconVisible = true,
  });

  final String title;
  final bool? isBackIconVisible;
  final bool? hasBackButton;
  final Widget? leading;
  double? vertical;
  double? size;
  String?subTitle;
  bool? isManask;
   final bool? isVerses;
  Color? backgroundColor;
  final Widget? triling;
  final Color? titleColor;
  void Function()? onTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Opacity(
         opacity:!GlobalFunctions.getShowCase()&&isVerses!?0.1:1,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: AppBar(
          backgroundColor:backgroundColor?? Colors.transparent,
          
          leading:  hasBackButton == null?
          
          SizedBox.shrink():
           hasBackButton == true
              ? isBackIconVisible!
                  ? InkWell(
                      onTap:onTap?? () {
                        if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        // Handle the case when there's no route to pop
        // For example, show a message or navigate to a different screen
      }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical:vertical?? 20.h),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(14.sp)),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white,
                          size:size?? 18.sp,
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 15.h),
                      // padding: EdgeInsets.symmetric(horizontal:5.w),
                      decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14)),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            scaffoldKey?.currentState!.openDrawer();
                          },
                          child: Icon(
                              Icons.menu_rounded,
                              color: AppColors.white,
                              
                            ),
                        ),
                      ),
                    )
              : null,
          leadingWidth:hasBackButton==null?0.w: 40.w,
          surfaceTintColor: AppColors.white,
          centerTitle: false,
          actions: [
          triling ?? Container(),
          ],
          title:isManask!=null? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text16(
                text: title,
                isBold: true,
                textAlign: TextAlign.start,
                color: titleColor ?? AppColors.black,
              ),
                Text14(
                text: subTitle??'',
                // isBold: true,
                textAlign: TextAlign.start,
                color: AppColors.black,
              ),
            ],
          ):Text16(
            text: title,
            isBold: true,
             textAlign: TextAlign.start,
            color: titleColor ?? AppColors.black,
          ),
        ),
      ),
    );
  }
}
