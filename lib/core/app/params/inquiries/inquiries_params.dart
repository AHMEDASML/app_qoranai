import 'package:Al_Arqam/core/resources/type_def.dart';

class InquiriesParams with Params {
  final String? type;
  final int? startIndex;
  final int? limit;
  final String? searchTerm;

  InquiriesParams({this.type, this.startIndex, this.limit, this.searchTerm});

  @override
  QueryParams getParams() {
    return {
      'type': type.toString(),
      'startIndex': startIndex.toString(),
      'limit': limit.toString(),
      'searchTerm': searchTerm.toString()
    };
  }
}
