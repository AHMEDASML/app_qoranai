import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_empty.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_nesseccary_login.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_reload.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_send_question_mufti.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_text_form.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_tile.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_trailing.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_type.dart';
import 'package:Al_Arqam/core/enums/ask_camping_mufti_enum.dart';
import 'package:Al_Arqam/core/resources/app_boxs_name.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/pref_keys.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/ask_camping_mufti/controller/ask_camping_mufti_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AskCampingMuftiView extends StatefulWidget {
  const AskCampingMuftiView({super.key});

  @override
  State<AskCampingMuftiView> createState() => _AskCampingMuftiViewState();
}

class _AskCampingMuftiViewState extends State<AskCampingMuftiView> {
  @override
  void initState() {
    super.initState();
  }

  AskCampingMuftiController controller = Get.find<AskCampingMuftiController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secoundaryBackground,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'ask_mufti'.tr,
          backgroundColor: AppColors.white,
          triling: CustomTrailing(),
        ),
        body: GetBuilder<AskCampingMuftiController>(
          builder: (controller) {
            return GetBuilder<MainController>(
              builder: (mainController) {
                return RefreshIndicator(
                  onRefresh:() async{
                    controller.onInit();

                  },

                  
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 1.h,
                              color: AppColors.greyVerfication,
                            ),
                            Visibility(
                              visible: Hive.box(AppBox.configBox).get(PrefKeys.token) != null,
                              child: SizedBox(height: 20.h),
                            ),
                            Visibility(
                              visible: Hive.box(AppBox.configBox).get(PrefKeys.token) != null,
                              child: Container(
                                height: 50.h,
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.containerGrey,
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTap(
                                      width: 180.w,
                                      color: controller.selectedTab.value == AskCampingMuftiEnum.fatwas
                                          ? AppColors.primary
                                          : AppColors.containerGrey,
                                      text: 'fatwas'.tr,
                                      textColor: controller.selectedTab.value == AskCampingMuftiEnum.fatwas
                                          ? AppColors.white
                                          : AppColors.textSecoundary,
                                      onTap: () {
                                        controller.changeTab(AskCampingMuftiEnum.fatwas);
                                        controller.update();
                                      },
                                    ),
                                    CustomTap(
                                      width: 180.w,
                                      color: controller.selectedTab.value == AskCampingMuftiEnum.myquestions
                                          ? AppColors.primary
                                          : AppColors.containerGrey,
                                      text: 'my_questions'.tr,
                                      textColor: controller.selectedTab.value == AskCampingMuftiEnum.myquestions
                                          ? AppColors.white
                                          : AppColors.textSecoundary,
                                      onTap: () {
                                        controller.changeTab(AskCampingMuftiEnum.myquestions);
                                        controller.update();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Visibility(
                              visible: controller.selectedTab.value == AskCampingMuftiEnum.fatwas,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Container(
                                  height: 55.h,
                                  child: CustomTextField(
                                    contentPadding: EdgeInsets.only(top: 5.h, bottom: 5.w),
                                    borderRaduis: 20.r,
                                    isFilled: false,
                                    controller: controller.searchController,
                                    hintText: 'search_placeholder'.tr,
                                    prefixIcon: InkWell(
                                      onTap: () {
                                        controller.fetchInquiries(type: "public", startIndex: 0, limit: 20, searchTerm: controller.searchController.text);
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: AppColors.textSecoundary,
                                      ),
                                    ),
                                    validator: (val) => GlobalFunctions.valid(val ?? "", 2, 600, context),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        controller.selectedTab.value == AskCampingMuftiEnum.myquestions
                            ? Container(
                                child: controller.isLoadingPrivate.value
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 150.h),
                                        child: GlobalFunctions.showLoading(AppColors.primary, size: 20.sp),
                                      )
                                     :controller.errorMessage.isNotEmpty?
                                     ErrorReloadWidget(onRetry:(){
                                      controller.fetchInquiries(type: 'private', startIndex: 0, limit: 20);
                                     },):
                                     
                                     controller.inquiriesResponsePrivate.value.inquiries.isEmpty?
                                    EmptyLottieWidget()
                                    : Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: controller.inquiriesResponsePrivate.value.inquiries.length,
                                          itemBuilder: (context, index) => InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.secoundaryBackground,
                                                  borderRadius: BorderRadius.circular(20.r),
                                                ),
                                                child: CustomTile(
                                                  fontsize: 12.sp,
                                                  title: controller.inquiriesResponsePrivate.value.inquiries[index].question!,
                                                  isExpansion: true,
                                                  leading: null,
                                                  answer: controller.inquiriesResponsePrivate.value.inquiries[index].answer ?? '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              )
                            : Container(
                                child: controller.isLoading.value
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 150.h),
                                        child: GlobalFunctions.showLoading(AppColors.primary, size: 20.sp),
                                      ):
                                      controller.errorMessagePublic.isNotEmpty?
                                     ErrorReloadWidget(onRetry:(){
                                     controller.fetchInquiries(type: 'public', startIndex: 0, limit: 20);
                                     },)
                                    :controller.inquiriesResponse.value.inquiries.isEmpty?
                                    EmptyLottieWidget():
                                    
                                     Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: controller.inquiriesResponse.value.inquiries.length,
                                          itemBuilder: (context, index) => InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.secoundaryBackground,
                                                  borderRadius: BorderRadius.circular(20.r),
                                                ),
                                                child: CustomTile(
                                                  fontsize: 12.sp,
                                                  title: controller.inquiriesResponse.value.inquiries[index].question!,
                                                  isExpansion: true,
                                                  leading: null,
                                                  answer: controller.inquiriesResponse.value.inquiries[index].answer!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                          child: CustomButton(
                            height: 90.h,
                            onPressed: () {
                              Hive.box(AppBox.configBox).get(PrefKeys.token) != null
                                  ? showCustomSendQuestionMufti(context)
                                  : showCustomNesseccaryLoginDialog(context);
                            },
                            borderRadius: 20.r,
                            backgroundColor: AppColors.primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ask.png',
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 10.w),
                                Text14(
                                  text: 'ask_question'.tr,
                                  color: AppColors.white,
                                  isBold: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}