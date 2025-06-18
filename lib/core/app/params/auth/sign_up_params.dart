import '../../../resources/type_def.dart';

class SignUpBody with Params {
  String? email;
  String? mobile;
  String password;
  String userName;
  String idCard;
  String legalStatus;
  SignUpBody(
      {this.email,
      this.mobile,
      required this.legalStatus,
      required this.password,
      required this.idCard,
      required this.userName});

  @override
  BodyMap getBody() {
 print('email: ${email}');
 print('mobile: ${mobile}');
    return {
      "username": userName,
      "email": email.toString().isEmpty?null:email,
      "mobile": mobile.toString().isEmpty?null:mobile,
      "password": password,
      "id_card": idCard.isEmpty?null:idCard,
      "legalStatus": legalStatus
    };
    
  }
}
