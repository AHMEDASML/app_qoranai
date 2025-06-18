import '../../../resources/type_def.dart';

class SendPasswordCodeBody with Params {
  String? email;
  String? mobile;
  SendPasswordCodeBody({
    this.email,
    this.mobile,
  });

  @override
  BodyMap getBody() {
    if (email == null || email == "") {
      return {"mobile": mobile};
    } else {
      return {"email": email};
    }
  }
}
