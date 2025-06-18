import 'package:Al_Arqam/core/app/general_widgets/custom_toast.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:Al_Arqam/services/auth_service.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends MainController  {
 GeneralModel? response;

   var isLoadingDelete= false.obs;
     var isLoading= false.obs;
  var errorMessage = ''.obs;
    Future<void> logout(
    BuildContext context,
  
  
  ) async {
    isLoadingDelete.value=true;

    errorMessage.value = '';
    update();
    try {
      
       response = await AuthService().logout();
      
      isLoadingDelete.value=false;
    
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AppRoutesPath.mainRoute); // Get.back();
      GlobalFunctions.removeToken();
      GlobalFunctions.removeEmail();
      GlobalFunctions.removeIdCode();
      GlobalFunctions.removeUsername();
       GlobalFunctions.removeLegalStatus();
       
       
      // update();
      // print('ffffffffffffffffff${ inquiriesResponse.value.inquiries}');
    } catch (e) {
    
         isLoadingDelete.value=false;
      //  AppConstants.showToast(context, "فشلت عملية التعديل, حاول مرة ثانية",succsess: false);
      errorMessage.value = e.toString();
    } finally {
      
      update();
    }
  }
 



}