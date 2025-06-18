// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:Al_Arqam/core/resources/type_def.dart';

class VersesParam with Params {
  int? chapterNumber;
  int? juzNumber;
  int? pageNumber;
  VersesParam({
    this.chapterNumber,
    this.juzNumber,
    this.pageNumber,
  });

  @override
  QueryParams getParams() {
    return {
      "chapter_number": chapterNumber.toString(),
      // "juz_number": juzNumber.toString(),
      // "page_number": pageNumber.toString(),
    };
  }
}
