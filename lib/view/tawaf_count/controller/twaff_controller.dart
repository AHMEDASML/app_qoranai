import 'package:Al_Arqam/view/main_controller.dart';

class TwaffController extends MainController {
  String tawafInstructionsSelected="manask_twaff_1";
  String saiInstructionsSelected= "manask_saee_1";
   String tawafdwaSelected= "dwa_twaff_1";
    String saeedwaSelected= "saee_twaff_1";
  bool isStart=false;
  List<String> tawafInstructions=[
    "manask_twaff_1",
    "manask_twaff_2"
  ];
  List<String> saiInstructions=[
    "manask_saee_1",
    "manask_saee_2",
    "manask_saee_3"
  ];
   List<String> tawafdwa=[
    "dwa_twaff_1",
    "dwa_twaff_2",
    "dwa_twaff_3",
     "dwa_twaff_4",
    "dwa_twaff_5",
    "dwa_twaff_6",
     "dwa_twaff_7"
  ];
  List<String> saeedwa=[
    "saee_twaff_1",
    "saee_twaff_2",
    "saee_twaff_3",
     "saee_twaff_4",
    "saee_twaff_5",
    "saee_twaff_6",
    
  ];
void changeIsStart(){
  isStart=!isStart;
  update();
}
  void chooseTawafInstructions(int count){
    if(count==0){
      tawafInstructionsSelected=tawafInstructions[0];
    }else{
       tawafInstructionsSelected=tawafInstructions[1];
    }

  }
   void chooseSaiInstructions(int count){
    if(count==0){
      saiInstructionsSelected=saiInstructions[0];
    }else if(count%2==1){
       saiInstructionsSelected=saiInstructions[1];
    }else if(count%2==0){
       saiInstructionsSelected=saiInstructions[2];
    }

  }
  void chooseTawafDwa(int count){
      tawafdwaSelected=tawafdwa[count];
  }
   void chooseSaeeDwa(int count){

      saeedwaSelected=saeedwa[count==6?1:count];
  }
}