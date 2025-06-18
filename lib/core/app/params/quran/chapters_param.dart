// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:Al_Arqam/core/resources/type_def.dart';

class ChaptersParam with Params {
  int? juzNumber;

  ChaptersParam({
    this.juzNumber,
  });

  @override
  QueryParams getParams() {
    return {
      "juz_number": juzNumber.toString(),
    };
  }
}
