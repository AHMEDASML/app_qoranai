import 'package:Al_Arqam/core/resources/global_functions.dart';

import '../../../resources/type_def.dart';

class ResetPasswordBody with Params {
  String? passwordToken;
  String? password;
  ResetPasswordBody({
    this.passwordToken,
    this.password,
  });

  @override
  BodyMap getBody() {
    return {"passwordCode": GlobalFunctions.getVerificatonCode(), "newPassword": password,"email":GlobalFunctions.getEmail()};
  }
}
