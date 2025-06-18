import 'package:Al_Arqam/core/enums/hajj_enum.dart';
import 'package:Al_Arqam/core/enums/hajj_rituals_enum.dart';

import 'package:Al_Arqam/view/main_controller.dart';
import 'package:get/get.dart';

class HajjRitualsController extends MainController {
   var selectedTab = HajjRitualsEnum.text.obs;
     var selectedTabHajj = HajjEnum.person.obs;
      var selectedalqdomTab = twaffAlqdomEnum.text.obs;
      bool isShowManask=false;
        

      int indexManask=0;
        int indexManaskTamatoa=0;
void changeIndexManask(int index){
indexManask=index;
}
void changeIndexManaskTamatoa(int index){
indexManaskTamatoa=index;
}
 void changeTab(HajjRitualsEnum tab) {
    selectedTab.value = tab;
  }
  void changeTabAlqdom(twaffAlqdomEnum tab) {
    selectedalqdomTab.value = tab;
  }
  void changeTabHajj(HajjEnum tab) {
    selectedTabHajj.value = tab;
  }
     void changeShowManask() {
   isShowManask = !isShowManask;
   update();
  }

}