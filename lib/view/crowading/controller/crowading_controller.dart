import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/enums/crowading_enum.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/models/crowading/crowading_model.dart';
import 'package:Al_Arqam/services/crowading_service.dart';

class CrowadingController extends GetxController {
  var selectedTab = CrowadingTypes.tawaf.obs;

  var floorstwaf = <String>[
    'surface'.tr,      // "السطح"
    'mezanen'.tr,      // "الميزانان"
    'ground_floor'.tr, // "الطابق الارضي"
    'first_floor'.tr,  // "الطابق الاول"
    'sahen'.tr,        // "الصحن"
  ].obs;

  var floorsaae = <String>[
    'basement'.tr,     // "القبو"
    'ground_floor'.tr, // "الطابق الأرضي"
    'first_floor'.tr,  // "الطابق الاول"
    'mezanen'.tr,      // "الميزانان"
    'sahen'.tr,        // "الصحن"
  ].obs;

  var floorjamrat = <String>[
    'ground_floor'.tr,  // "الطابق الأرضي"
    'first_floor'.tr,   // "الطابق الاول"
    'second_floor'.tr,  // "الطابق الثاني"
    'third_floor'.tr,   // "الطابق الثالث"
    'fourth_floor'.tr,  // "الطابق الرابع"
  ].obs;

  var densities = <String>[
    'low_density'.tr,        // "منخفض"
    'medium_density'.tr,     // "متوسط"
    'high_density'.tr,       // "كثيف"
    'very_high_density'.tr,  // "شديد الكثافة"
    'crowded_dangerous'.tr,  // "مزدحم جداً (خطير)"
    'closed'.tr,             // "مغلق"
  ].obs;

  var crowdingResponse = CrowdingResponse(success: false).obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  CrowdingResponse response = CrowdingResponse(success: false);

  @override
  void onInit() {
    fetchCrowdingData();
    super.onInit();
  }

  void fetchCrowdingData() async {
    try {
      isLoading(true);
      response = await ApiService().fetchCrowding();
      crowdingResponse.value = response;
      update();
    } catch (e) {
      isLoading(false);
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void changeTab(CrowadingTypes tab) {
    selectedTab.value = tab;
  }

  Color selectColorFromNumber(int num) {
    if (num <= 10) {
      return AppColors.lowColor;
    } else if (num > 10 && num <= 30) return AppColors.midColor;
    else if (num > 30 && num <= 50) return AppColors.floor3Color;
    else if (num > 50 && num <= 90) return AppColors.floor4Color;
    else return AppColors.floor5Color;
  }

  String selectLevelFromNumber(int num) {
    if (num <= 10) {
      return densities[0];
    } else if (num > 10 && num <= 30) return densities[1];
    else if (num > 30 && num <= 50) return densities[2];
    else if (num > 50 && num <= 90) return densities[3];
    else return densities[4];
  }

  double convertToNumber(String num) {
    return double.parse(num.replaceAll("%", "")) / 100;
  }

  int intToNumber(String num) {
    return int.parse(num.replaceAll("%", ""));
  }
}