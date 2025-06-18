
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WepVewScreen extends StatefulWidget {
  final String url;
  final String title;
  const WepVewScreen({super.key, required this.url, required this.title});

  @override
  State<WepVewScreen> createState() => _WepVewScreenState();
}

class _WepVewScreenState extends State<WepVewScreen> {
  WebViewController controller = WebViewController();
  int state = 0;
  String errorScreen = '';
  String urL = '';
  @override
  void initState() {
    urL = widget.url;
    controller = controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            state = 0;
          });
        },
        onProgress: (progress) {
          // setState(() {
          //   state = progress;
          // });
        },
        onPageFinished: (url) {
          setState(() {
                 errorScreen ='';
            state = 100;
          });
        },
        onWebResourceError: (error) {
          // setState(() {
          //   state = 100;
          //   print(';;;;;;;;;;;;;;;;;;;;;;;');
          //   // errorScreen = 'error';
          // });
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(urL));

    // WebViewController()
    // ..setJavaScriptMode(JavaScriptMode.disabled)
    // ..loadRequest(
    //   Uri.parse(urL),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ConstColor.primary2,
      body:   SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                disabledColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon:SizedBox(
                                              width:35.w,
                                              height:35.h,
                                              child:
                                             
                                                SvgPicture.asset('assets/svgs/close.svg',color:AppColors.primary,),
                                               )),


                          
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal:20.w),
                            child: Center(
                              child: Text(widget.title,
                                                                                    style: TextStyle(
                                                                                     
                                                                                      color:
                                                                                          AppColors.primary,
                                                                                      fontWeight:
                                                                                          FontWeight.bold,
                                                                                      fontSize: 16.sp,
                                                                                    ),
                                                                                  ),
                            ),
                          ),
                        ],
                      ),
                      state != 100
          ?  Expanded(child:Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10.h),
                                      child: Center(
                                        child: GlobalFunctions.showLoading(
                                            AppColors.primary, size: 25.sp),
                                      ),
                                    ),
                                  ))
          :
                      Expanded(
                        child: WebViewWidget(
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                )
              
    );
  }
}
  