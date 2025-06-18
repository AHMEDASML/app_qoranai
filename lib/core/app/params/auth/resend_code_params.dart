import '../../../resources/type_def.dart';

class ResendCodeBody with Params {
  String? email;
  String? mobile;
  ResendCodeBody({
    this.email,
    this.mobile,
  });

  @override
  BodyMap getBody() {
    
      return {"email": email,"mobile":mobile};
    
  }
}
