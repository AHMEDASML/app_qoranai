import 'package:Al_Arqam/controllers/language/language_controller.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition =GlobalFunctions.getLangCode()=='ar'? true:false;
  LanguageController  controller=Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    return
     Directionality(
      textDirection: TextDirection.ltr,
       child: Container(
        width: 100.w,
        height: 150.h,
         margin: EdgeInsets.symmetric(vertical:20.h),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                initialPosition = !initialPosition;
                var index = 1;
                if (!initialPosition) {
                  index = 0;
                }
                 
                widget.onToggleCallback(index);
                controller.changeLanguage(index==1?'ar':"en");
                 GlobalFunctions.setLanguageCode(index==1?'ar':"en");
                setState(() {
       
                });
              },
              child: Container(
                width: 100.w,
        height: 150.h,
                decoration: ShapeDecoration(
                  color: widget.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Get.width * 0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    widget.values.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        widget.values[index],
                        style: TextStyle(
                          fontFamily: "NotoKufiArabic",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xAA000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              alignment:
                  initialPosition ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                 width: 60.w,
        height: 150.h,
                decoration: ShapeDecoration(
                  color: widget.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Get.width * 0.1),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  initialPosition ? widget.values[0] : widget.values[1],
                  style: TextStyle(
                    fontFamily: "NotoKufiArabic",
                    fontSize: 14.sp,
                    color: widget.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
           ),
     );
  
  
  }
}