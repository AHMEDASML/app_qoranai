// ignore_for_file: use_build_context_synchronously

import 'package:Al_Arqam/core/app/general_widgets/custom_toast.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/toast.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:Al_Arqam/services/auth_service.dart';
import 'package:Al_Arqam/services/my_account_service.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class MyAccountController extends MainController {
 
   GeneralModel? response;

   var isLoadingUpdate= false.obs;
  var isLoading= false.obs;
  var isLoadingDelete= false.obs;
  var errorMessage = ''.obs;
  
   
  final MyAccountService myAccountService = MyAccountService();
 @override
  void onInit() {
    super.onInit();
   
  }
  
  Future<void> deleteAccount(
    BuildContext context,
    String password
  
  
  ) async {
    isLoadingDelete.value=true;

    errorMessage.value = '';
    update();
    try {
      
       response = await AuthService().deleteAccount(body:{
        "enteredPassword":password
       });
      
      isLoadingDelete.value=false;
    
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );// Get.back();
      GlobalFunctions.removeToken();
      GlobalFunctions.removeEmail();
      GlobalFunctions.removeIdCode();
      GlobalFunctions.removeUsername();
       GlobalFunctions.removeLegalStatus();
       
       
      // update();
      // print('ffffffffffffffffff${ inquiriesResponse.value.inquiries}');
    } catch (e) {
     print("llllllllllllllllllllllll${e}");
         isLoadingDelete.value=false;
          Toast.showText(text: response!.message!);
      //  AppConstants.showToast(context, "فشلت عملية التعديل, حاول مرة ثانية",succsess: false);
      errorMessage.value = e.toString();
    } finally {
      
      update();
    }
  }

  
  Future<void> updateProfile(
    BuildContext context,
    String name,
    String? IdCode,
    String legalStatus,
  
  ) async {
    isLoadingUpdate.value=true;

    errorMessage.value = '';
    update();
    try {
       print(IdCode);
       response = await myAccountService.updateMyAccount
       (body:{
       
	"username":name,
    "legalStatus": legalStatus,
    "id_card": IdCode,
    "avatar": "images/image-874834839783.png"  // just this one not required

       }
       
      );
     
      isLoadingUpdate.value=false;
    
        Toast.showText(text: response!.message!);
      GlobalFunctions.setIdCode(IdCode);
      GlobalFunctions.setUsername(name);
      GlobalFunctions.setLegalStatus(legalStatus);
      Get.back();
      update();
      // print('ffffffffffffffffff${ inquiriesResponse.value.inquiries}');
    } catch (e) {
      // print("llllllllllllllllllllllll${e}");
isLoadingUpdate.value=false;
         Toast.showText(text: response!.message!);
      errorMessage.value = e.toString();
    } finally {
      
      update();
    }
  }
 
}