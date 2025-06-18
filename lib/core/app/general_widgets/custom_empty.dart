import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyLottieWidget extends StatelessWidget {


  final double height;
  final double width;

  const EmptyLottieWidget({
    Key? key,
   
    
    this.height = 200,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/empty.json',
            height: height.h,
            width: width.w,
            fit: BoxFit.contain,
          ),
            SizedBox(height: 150.h),
         
          
        ],
      ),
    );
  }
}
