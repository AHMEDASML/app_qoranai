import 'package:Al_Arqam/models/quran/chapter_model.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class QuranController extends MainController{
  RxInt chapterIndex=0.obs;
  List<Chapter> chapters=[];
  void changeIndex(int index){
     print( 'زززززززززززززززز${index}');
    chapterIndex.value=index;
  }
}