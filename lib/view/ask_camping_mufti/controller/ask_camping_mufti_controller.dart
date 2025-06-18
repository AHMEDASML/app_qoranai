// ignore_for_file: use_build_context_synchronously

import 'package:Al_Arqam/core/app/general_widgets/custom_toast.dart';
import 'package:Al_Arqam/core/enums/ask_camping_mufti_enum.dart';
import 'package:Al_Arqam/core/resources/toast.dart';
import 'package:Al_Arqam/models/camping_mufti/ask_camping_mufti_model.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:Al_Arqam/services/ask_camping_mufti_service.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class AskCampingMuftiController extends MainController {
  var inquiriesResponse = InquiriesResponse(success: false, message: '', inquiries: []).obs;
   var inquiriesResponsePrivate = InquiriesResponse(success: false, message: '', inquiries: []).obs;
   GeneralModel? response;
  var isLoading = false.obs;
   var isLoadingAdd = false.obs;
   var isLoadingPrivate = false.obs;
  var errorMessage = ''.obs;
   var errorMessagePublic = ''.obs;
   TextEditingController searchController=TextEditingController();
      TextEditingController inqueryDetails=TextEditingController();
   var selectedTab = AskCampingMuftiEnum.fatwas.obs;
  final InquiryService inquiryService = InquiryService();
 @override
  void onInit() {
    super.onInit();
    fetchInquiries(type: 'public', startIndex: 0, limit: 30);
    fetchInquiries(type: 'private', startIndex: 0, limit: 30);
  }
  Future<void> fetchInquiries({
    required String type,
    required int startIndex,
    required int limit,
    String? searchTerm,
  }) async {
     if(type=='public')
    {isLoading.value = true;
    errorMessagePublic.value='';
    }else
    {isLoadingPrivate.value = true;
    errorMessage.value = '';}
    update();
    try {
      if(type=='public')
      {inquiriesResponse.value = await inquiryService.fetchInquiries(
        type: type,
        startIndex: startIndex,
        limit: limit,
        searchTerm: searchTerm,
      );}else{
        inquiriesResponsePrivate.value = await inquiryService.fetchInquiries(
        type: type,
        startIndex: startIndex,
        limit: limit,
        searchTerm: searchTerm,
      );
      }
      print('ffffffffffffffffff${ inquiriesResponse.value.inquiries}');
    } catch (e) {
      if(type=='public')
      {errorMessagePublic.value = e.toString();}else{errorMessage.value = e.toString();}
    } finally {
      if(type=='public')
    {isLoading.value = false;}else{isLoadingPrivate.value = false;}
      update();
    }
  }
  Future<void> addInquiries(
    BuildContext context
  
  ) async {
    isLoadingAdd.value=true;

    errorMessage.value = '';
    update();
    try {
      
       response = await inquiryService.addInquiries(body:{
        "question":inqueryDetails.text
       }
       
      );
      isLoadingAdd.value=false;
      inqueryDetails.clear();
 fetchInquiries(type: 'private', startIndex: 0, limit: 30);
      // AppConstants.showToast(context, "تم إضافة السؤال بنجاح",succsess: true);
      Get.back();
      // print('ffffffffffffffffff${ inquiriesResponse.value.inquiries}');
    } catch (e) {
      // print("llllllllllllllllllllllll${e}");
isLoadingAdd.value=false;

      //  AppConstants.showToast(context, "فشلت عملية الإضافة, حاول مرة ثانية",succsess: false);
      errorMessage.value = e.toString();
    } finally {
 Toast.showText(text: response!.message!);
      update();
    }
  }
  void changeTab(AskCampingMuftiEnum tab) {
    selectedTab.value = tab;
   
  }
}