import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/view/main_controller.dart';

class FontSizeDialog extends StatefulWidget {
  final double initialFontSize;
  final Function(double) onFontSizeChanged;

  const FontSizeDialog({
    super.key,
    required this.initialFontSize,
    required this.onFontSizeChanged,
  });

  @override
  _FontSizeDialogState createState() => _FontSizeDialogState();
}

class _FontSizeDialogState extends State<FontSizeDialog> {
  late double fontSize;

  @override
  void initState() {
    super.initState();
    fontSize = widget.initialFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 10.h),
       buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
         titlePadding: EdgeInsets.only(right:20.w,top: 20.h),
          iconPadding: EdgeInsets.zero,
           actionsPadding: EdgeInsets.symmetric(horizontal:  10.w,vertical:5.h),
      title: Text(
        'تغيير حجم الخط',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      content: Container(
        height: 188.h,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             SizedBox(height: 15.h),
            Text(
              'اختر حجم الخط:',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 10.h),
            Slider(
              value: fontSize,
              min: 12,
              max: 20,
              divisions: 25,
              label: fontSize.toStringAsFixed(1),
              onChanged: (newFontSize) {
                setState(() {
                  fontSize = newFontSize;
                });
              },
            ),
            SizedBox(height: 10.h),
            Text(
              'Aa',
              style: TextStyle(fontSize: fontSize.sp), // Adjusted to reflect font size
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onFontSizeChanged(fontSize); // Pass the new font size
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
            'موافق',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ), // OK in Arabic
        ),
      ],
    );
  }
}

void showFontSizeDialog(BuildContext context, double currentFontSize) {
  showDialog(
    context: context,
    builder: (context) {
      return FontSizeDialog(
        initialFontSize: Get.find<MainController>().fontSize.value,
        onFontSizeChanged: (newFontSize) {
          // Update the font size in your app
          Get.find<MainController>().fontSize.value = newFontSize;
          Get.find<MainController>().update();
        },
      );
    },
  );
}