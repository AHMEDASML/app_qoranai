import '../../../resources/type_def.dart';

class VerficationCodeParams with Params {
  String? email;
  String? mobile;
  String? verificationCode;
 

  VerficationCodeParams({
   
    this.email,
   this.verificationCode,
    this.mobile,
  });

  @override
  BodyMap getBody() {
    return {
      "email": email,
      "mobile": mobile,
     
      "verificationCode": verificationCode,};
  }
}
