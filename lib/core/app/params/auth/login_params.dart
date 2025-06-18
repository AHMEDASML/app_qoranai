// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:Al_Arqam/core/resources/type_def.dart';

class LoginBody with Params {
  String? email;
  String? mobile;
  String? password;
  LoginBody({
    this.email,
    this.mobile,
    this.password,
  });
  

  @override
  BodyMap getBody() {
    return {"email": email, "mobile": mobile, "password": password};
  }
}
