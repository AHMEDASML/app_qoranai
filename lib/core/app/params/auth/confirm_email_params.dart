import '../../../resources/type_def.dart';

class ConfirmEmailBody with Params {
  String? email;
  String? mobile;
  ConfirmEmailBody({
    this.email,
    this.mobile,
  });

  @override
  BodyMap getBody() {
    if (email == null || email == "") {
      return {"mobile": mobile,};
    } else {
      return {"email": email};
    }
  }
}
