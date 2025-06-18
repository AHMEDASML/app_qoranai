import 'dart:ui';

import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:get/get.dart';


class LanguageController extends GetxController {
  var locale = GlobalFunctions.getLangCode()=='en'? const Locale('en', 'Us'): const Locale('ar', 'Ar');
  

  void changeLanguage(String langCode) {
    locale = Locale(langCode);
    Get.updateLocale(locale);
  }
}