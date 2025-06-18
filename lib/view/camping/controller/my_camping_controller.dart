import 'package:Al_Arqam/core/enums/camping_enum.dart';
import 'package:Al_Arqam/models/capmping/camping_model.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCampingController extends MainController {
    
    var selectedTab = CampingEnum.guide.obs;
    ProgramCamping? selectedProgram;
  

    String campinAppBar="my_camping".tr;
    void changeTab(CampingEnum tab) {
    selectedTab.value = tab;
     campinAppBar="my_camping".tr;
  }
  void launchWhatsApp(String phoneNumber) async {
  // Replace with the recipient's number
  final url = 'whatsapp://send?phone=$phoneNumber';
  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  
}