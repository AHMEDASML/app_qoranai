import '../../../resources/type_def.dart';

class ConfirmPasswordCodeBody with Params {
  String? email;
  String? mobile;
  String? passwordCode;
  ConfirmPasswordCodeBody({this.email, this.passwordCode, this.mobile});

  @override
  BodyMap getBody() {
    if (email == null || email == "") {
      return {"mobile": mobile, "passwordCode": passwordCode};
    } else {
      return {"email": email, "passwordCode": passwordCode};
    }
  }
}
