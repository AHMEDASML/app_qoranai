import 'package:Al_Arqam/core/network/get_api.dart';
import 'package:Al_Arqam/core/resources/type_def.dart';
import 'package:Al_Arqam/models/quran/chapter_model.dart';
import 'package:Al_Arqam/models/quran/juzs_model.dart';
import 'package:Al_Arqam/models/quran/verses_model.dart';

import '../../../core/network/api_variables.dart';

class QuranDataSource {
  Future<JuzsModel> getJuzs() async {
    GetApi getJuzs =
        GetApi(uri: ApiVariables.getJuzs(), fromJson: juzsModelFromJson);
    var result = await getJuzs.callRequest();
    return result;
  }

  Future<ChapterModel> getChapters(QueryParams? params) async {
    GetApi getChapters =
        GetApi(uri: ApiVariables.getChapters(params: params), fromJson: chapterModelFromJson);
    var result = await getChapters.callRequest();
    return result;
  }

  Future<VersesModel> getVerses(QueryParams params) async {
    GetApi getVerses = GetApi(
        uri: ApiVariables.getVerses(params: params),
        fromJson: versesModelFromJson);
    var result = await getVerses.callRequest();
    return result;
  }
}
