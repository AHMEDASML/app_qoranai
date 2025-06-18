import 'package:Al_Arqam/core/app/params/auth/confirm_password_code_param.dart';
import 'package:Al_Arqam/models/auth/verify_email_model.dart';
import 'package:Al_Arqam/models/general_model.dart';

import '../../../core/network/api_variables.dart';
import '../../../core/network/post_api.dart';
import '../../../core/resources/type_def.dart';
import '../login_model.dart';

import '../sign_up_model.dart';

class AuthDataSource {
  Future<GeneralModel> forgetPassword(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.sendPasswordCode(),
        body: body,
        fromJson: generalModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }

  Future<GeneralModel> confirmPasswordCode(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.cnfirmPasswordCode(),
        body: body,
        fromJson: generalModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }

  Future<SignUpModel> signUp(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.signUp(), body: body, fromJson: signUpModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }

  Future<LoginModel> login(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.login(), body: body, fromJson: loginModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }

  Future<GeneralModel> resetPassword(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.resetPassword(),
        body: body,
        fromJson: generalModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }

  Future<GeneralModel> resendCode(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.resendCode(),
        body: body,
        fromJson: generalModelFromJson);
    print("Body is :$body");

    var result = await postApi.callRequest();
    return result;
  }

  Future<VerifyEmailModel> verifyEmail(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.verifyEmail(),
        body: body,
        fromJson: verifyEmailModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }

  Future<GeneralModel> cnfirmPasswordCode(BodyMap body) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.cnfirmPasswordCode(),
        body: body,
        fromJson: generalModelFromJson);
    var result = await postApi.callRequest();
    return result;
  }
}
