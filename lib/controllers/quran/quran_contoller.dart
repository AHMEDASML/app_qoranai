import 'package:Al_Arqam/core/resources/type_def.dart';
import 'package:Al_Arqam/models/quran/chapter_model.dart';
import 'package:Al_Arqam/models/quran/data_sources/quran_data_source.dart';
import 'package:Al_Arqam/models/quran/juzs_model.dart';
import 'package:Al_Arqam/models/quran/verses_model.dart';

import '../../core/handling_error/handling_exception_manager.dart';

abstract class QuranController {
  DataResponse<JuzsModel> getJuzs();
  DataResponse<ChapterModel> getChapters({QueryParams? params});
  DataResponse<VersesModel> getVerses(QueryParams params);
}

class QuranContollerImp
    with HandlingExceptionManager
    implements QuranController {
  final quranDataSource = QuranDataSource();
  @override
  DataResponse<ChapterModel> getChapters({QueryParams? params}) {
    var result = wrapHandling(
      tryCall: () {
        return quranDataSource.getChapters( params);
      },
    );
    return result;
  }

  @override
  DataResponse<JuzsModel> getJuzs() {
    var result = wrapHandling(
      tryCall: () {
        return quranDataSource.getJuzs();
      },
    );
    return result;
  }

  @override
  DataResponse<VersesModel> getVerses(QueryParams params) {
    var result = wrapHandling(
      tryCall: () {
        return quranDataSource.getVerses(params);
      },
    );
    return result;
  }
}
