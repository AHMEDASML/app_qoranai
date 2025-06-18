
import 'package:Al_Arqam/core/resources/text/text10.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/view/quran/controller/quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/asset_manger.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text20.dart';
import 'package:get/get.dart';


import '../../core/app/general_widgets/custom_app_bar.dart';
import '../../core/app/general_widgets/custom_button.dart';
import '../../core/app/general_widgets/custom_no_internet.dart';
import '../../core/app/params/quran/verses_param.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/text/text14.dart';
import '../../core/resources/text/text16.dart';
import 'bloc/quran_bloc.dart';
import 'package:lottie/lottie.dart';
class VersesScreen extends StatefulWidget {
  final int? chapterId;
  final String? chapterName;

  const VersesScreen({super.key, this.chapterId, this.chapterName});

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  late QuranBloc bloc;
  

  @override
  void initState() {
    bloc = QuranBloc()
      ..add(GetVerses(versesParam: VersesParam(chapterNumber: widget.chapterId)));
       SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
       DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    super.initState();
  }


  @override
  void dispose() {
    // Restore preferred orientations to portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
   QuranController controller=Get.find<QuranController>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<QuranBloc, QuranState>(
        listener: (context, state) {
          // Handle any state changes if needed
        },
        builder: (context, state) {
          return MediaQuery.of(context).orientation == Orientation.portrait?
         PopScope(
          canPop: false,
            onPopInvoked: (_) async {
        Navigator.of(context).pushNamed(AppRoutesPath.chaptersRoute);
        // return false; // Prevent default pop behavior
      },
           child: Scaffold(
              backgroundColor: AppColors.quranColor1,
              appBar: CustomAppBar(
                title: "",
                isVerses: true,
                backgroundColor: AppColors.quranColor1,
                onTap:(){
                   Navigator.of(context).pushNamed(AppRoutesPath.chaptersRoute);
                },
                triling: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: CustomButton(
                       height: 60.h,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutesPath.quranNotesRoute);
                    },
                    child: Text14(
                      text: 'notes'.tr,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Opacity(
                    opacity:!GlobalFunctions.getShowCase()?0.1:1,
                    child: GestureDetector(
                       onHorizontalDragUpdate:
                        (details)
                         {
                        if (details.delta.dx > 0) {
                                          if(controller.chapterIndex.value<113)
                                        {  controller.changeIndex(controller.chapterIndex.value+1);
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => VersesScreen(
                                              chapterId:  controller.chapters[controller.chapterIndex.value].id,
                                              chapterName:
                                               controller.chapters[controller.chapterIndex.value].nameArabic,
                                            ),
                                          ));
                                         }
                                      
                        } else if (details.delta.dx < 0) {
                          if(controller.chapterIndex.value>0)
                           { controller.changeIndex(controller.chapterIndex.value-1);
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => VersesScreen(
                                              chapterId:  controller.chapters[controller.chapterIndex.value].id,
                                              chapterName:
                                               controller.chapters[controller.chapterIndex.value].nameArabic,
                                            ),
                                          ));}
                        }},
                     
                     
                     
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: ScreenUtil().screenHeight / 14,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(AppImages.surahName),
                                ),
                              ),
                              child: Text20(
                                text: widget.chapterName!,
                                color: AppColors.black,
                                isBold: true,
                              ),
                            ),
                            if (widget.chapterName == "التوبة") Container()
                            else
                              Image.asset(
                                AppImages.basmala,
                                width: ScreenUtil().screenWidth / 1.7,
                              ),
                            state.allVersesStatus == AllVersesStatus.load
                                ? Center(child: GlobalFunctions.showLoading(AppColors.primary))
                                : state.allVersesStatus == AllVersesStatus.fail
                                    ? CustomNoInternet(
                                        error: state.messageErrorVerses,
                                        onRefresh: () {
                                          bloc.add(GetVerses(versesParam: VersesParam(chapterNumber: widget.chapterId)));
                                        },
                                      )
                                    : RichText(
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'NotoKufiArabic',
                                            
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            ...List.generate(
                                              state.versesList.length,
                                              (index) => TextSpan(children: [
                                                TextSpan(
                                                  text: '${state.versesList[index].textUthmani} ',
                                                ),
                                                WidgetSpan(
                                                  alignment: PlaceholderAlignment.middle,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 40.h,
                                                    width: 40.h,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(AppImages.surahNumber),
                                                      ),
                                                    ),
                                                    child: Text16(
                                                      text: (index + 1).toString(),
                                                      color: AppColors.primary,
                                                      isBold: true,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                       opacity:GlobalFunctions.getShowCase()?0.0:1,
                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.all(40.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Lottie animation
                            SizedBox(
                              width: 200.w,
                              height: 200.w,
                              child: Lottie.asset('assets/images/swipe.json'),
                            ),
                             SizedBox(height: 30.h),
                            // Instruction text
                             Text(
                              'swipe_navigation'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                 fontSize:18.sp,
                         fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                            fontFamily: 'NotoKufiArabic',
                              ),
                            ),
                             SizedBox(height: 30.h),
                            Padding(
                                        padding:  EdgeInsets.symmetric(vertical:10.h,horizontal:90.w),
                                        child: CustomButton(
                                        height:90.h,
                                        onPressed: () {
                                            setState(() {
                                              GlobalFunctions.setShowCase(true);
                                            });
                                          
                                        },
                                        borderRadius: 20.r,
                                        borderColor: AppColors.primary,
                                        isFillColor:false ,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            
                                            Text14(
                                              text:
                                                  "skip".tr,
                                              color:  AppColors.primary,
                                              isBold: true,
                                            ),
                                           
                                            // SizedBox(width: 10.w),
                                          ],
                                        ),
                                                                    ),
                                      ),
                                
                             SizedBox(height: 200.h),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
         ): Scaffold(
            backgroundColor: AppColors.quranColor1,
            appBar: CustomAppBar(
              title: "",
              vertical:15.h,
              size:12.sp,
              backgroundColor: AppColors.quranColor1,
              triling: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: CustomButton(
                     height: 80.h,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutesPath.quranNotesRoute);
                  },
                  child: Text10(
                    text: 'notes'.tr,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 80.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(AppImages.surahName),
                      ),
                    ),
                    child: Text14(
                      text: widget.chapterName!,
                      color: AppColors.black,
                      isBold: true,
                    ),
                  ),
                  if (widget.chapterName == "التوبة") Container()
                  else
                    Image.asset(
                      AppImages.basmala,
                      width: ScreenUtil().screenWidth / 1.7,
                    ),
                  state.allVersesStatus == AllVersesStatus.load
                      ? Center(child: GlobalFunctions.showLoading(AppColors.primary))
                      : state.allVersesStatus == AllVersesStatus.fail
                          ? CustomNoInternet(
                              error: state.messageErrorVerses,
                              onRefresh: () {
                                bloc.add(GetVerses(versesParam: VersesParam(chapterNumber: widget.chapterId)));
                              },
                            )
                          : RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                 fontFamily: 'NotoKufiArabic',
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                                children: [
                                  ...List.generate(
                                    state.versesList.length,
                                    (index) => TextSpan(children: [
                                      TextSpan(
                                        text: '${state.versesList[index].textUthmani} ',
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40.h,
                                          width: 40.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(AppImages.surahNumber),
                                            ),
                                          ),
                                          child: Text14(
                                            text: (index + 1).toString(),
                                            color: AppColors.primary,
                                            isBold: true,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}