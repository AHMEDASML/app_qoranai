// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:Al_Arqam/core/resources/type_def.dart';

class AddInquiryBody with Params {
  final String? question;

  AddInquiryBody({required this.question});

  @override
  BodyMap getBody() {
    return {"question": question};
  }
}
