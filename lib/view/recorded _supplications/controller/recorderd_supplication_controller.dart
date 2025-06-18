// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:get/get.dart';

import 'package:Al_Arqam/core/enums/recorder_supplications_enum.dart';
import 'package:Al_Arqam/models/recorded_supplications/recorded_supplications_model.dart';
import 'package:Al_Arqam/services/recorderd_supplications_service.dart';
import 'package:Al_Arqam/view/main_controller.dart';




class RecorderdSupplicationController extends MainController {
  var selectedTab = RecorderSupplicationsEnum.sunnah.obs;
  var supplicationsSunah = <Supplication>[].obs;
   var supplications = <Supplication>[].obs;
  var isLoading = false.obs;
  var isLoadingSunnh = false.obs;
  var currentPage = 0.obs;
  var hasMore = true.obs;
  String errorMessage='';
  String selectedaudio="";
   bool isPlayed=false;
   double valueslider=0;
  final RecorderdSupplicationsService apiService = RecorderdSupplicationsService();

  Future<void> fetchSupplications({int limit = 50, bool? fav, String? searchTerm}) async {
    // if (isLoading.value || !hasMore.value) return; // Prevent duplicate requests
    isLoading.value = true;
    errorMessage='';
    try {
      final List<Supplication> newSupplications = await apiService.fetchSupplications(
        startIndex: 0,
        limit: limit,
        classification: 'quran',
        fav: fav,
        searchTerm: searchTerm,
      );

      if (newSupplications.isNotEmpty) {
        supplications.addAll(newSupplications);
        currentPage.value++;
      } else {
        hasMore.value = false; 
      }
    update();
    } catch (e) {
      errorMessage=e.toString();
      // print('Error fetching supplications: $e');
    } finally {
      
      isLoading.value = false;
    }
  }
   Future<void> fetchSupplicationsSunah({int limit = 50, bool? fav, String? searchTerm}) async {
    // if (isLoadingSunnh.value || !hasMore.value) return; // Prevent duplicate requests
    isLoadingSunnh.value = true;
       errorMessage='';
    try {
      final List<Supplication> newSupplications = await apiService.fetchSupplications(
        startIndex:0,
        limit: limit,
        classification: 'sunah',
        fav: fav,
        searchTerm: searchTerm,
      );

      if (newSupplications.isNotEmpty) {
        supplicationsSunah.addAll(newSupplications);
        currentPage.value++;
      } else {
        hasMore.value = false; 
      }
    update();
    } catch (e) {
         errorMessage=e.toString();
      // print('Error fetching supplications: $e');
    } finally {
      isLoadingSunnh.value = false;
    }
  }
 
  @override
  void onInit()async {await fetchSupplicationsSunah();
    await fetchSupplications();
    
    super.onInit();
  }

  
  void changeTab(RecorderSupplicationsEnum tab) {
    selectedTab.value = tab;
  }
  
 
}