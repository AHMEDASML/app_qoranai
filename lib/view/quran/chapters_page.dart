import 'package:Al_Arqam/core/app/general_widgets/custom_reload.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:Al_Arqam/view/quran/controller/quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/params/quran/verses_param.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/core/resources/text/text20.dart';
import 'package:Al_Arqam/models/quran/chapter_model.dart';
import 'package:Al_Arqam/view/quran/verses_page.dart';
import 'package:get/get.dart';

import '../../core/app/general_widgets/custom_app_bar.dart';
import '../../core/app/general_widgets/custom_no_internet.dart';
import '../../core/resources/asset_manger.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/global_functions.dart';
import '../../core/resources/routes_manager.dart';
import '../../core/resources/text/text16.dart';
import 'bloc/quran_bloc.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  late QuranBloc bloc;

  @override
  void initState() {
    bloc = QuranBloc()..add(GetAllChapters());
    super.initState();
  }
  QuranController controller=Get.put(QuranController());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: GetBuilder<QuranController>(
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: (_) async {
        // Replace pushNamed with pushAndRemoveUntil
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
        // return false; // Prevent default pop behavior
      },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColors.quranColor1,
              appBar: CustomAppBar(
                backgroundColor: AppColors.quranColor1,
                title: 'chapters_index'.tr,
                hasBackButton: null,
               
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
              body: BlocBuilder<QuranBloc, QuranState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      bloc.add(GetAllChapters());
                    },
                    child: Center(
                      child: state.allChaptersStatus == AllChaptersStatus.load
                          ? Center(child: GlobalFunctions.showLoading(AppColors.primary))
                          : state.allChaptersStatus == AllChaptersStatus.fail
                              ?  Padding(
                                       padding:  EdgeInsets.only(top:250.h),
                                       child: ErrorReloadWidget(onRetry:(){
                                          bloc.add(GetAllChapters());
                                       },),
                                     )
                              
                              // CustomNoInternet(
                              //     error: state.messageErrorChapters,
                              //     onRefresh: () {
                              //     
                              //     },
                              //   )
                              : ListView(children: [
                                  ...List.generate(
                                    state.chaptersList.length,
                                    (index) => InkWell(
                                      onTap: () {
                                     
                                        
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => VersesScreen(
                                            chapterId: state.chaptersList[index].id,
                                            chapterName:
                                             state.chaptersList[index].nameArabic,
                                          ),
                                        ));
                                         controller.changeIndex(index);
                                         controller.chapters=state.chaptersList;
                                      },
                                      child: Container(
                                          height: ScreenUtil().screenHeight / 9,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                                          decoration: BoxDecoration(
                                              color: index % 2 == 0
                                                  ? AppColors.quranColor1
                                                  : AppColors.quranColor2),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 100.h,
                                                width: ScreenUtil().screenWidth / 8,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(AppImages.surahNumber))),
                                                child: Text16(
                                                  text: (index + 1).toString(),
                                                  color: AppColors.primary,
                                                  isBold: true,
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text20(
                                                    text: (state.chaptersList[index].nameArabic!).toString(),
                                                    isBold: true,
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  Text12(
                                                    text: "${state.chaptersList[index].revelationPlace == RevelationPlace.MADINAH ? 'madinah'.tr : 'makki'.tr} - آياتها ${state.chaptersList[index].versesCount!}",
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text16(
                                                text: (state.chaptersList[index].revelationOrder!).toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(width: 15.w)
                                            ],
                                          )),
                                    ),
                                  )
                                ]),
                    ),
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }
}