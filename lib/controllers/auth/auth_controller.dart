import 'package:Al_Arqam/models/auth/sign_up_model.dart';
import 'package:Al_Arqam/models/auth/verify_email_model.dart';
import 'package:Al_Arqam/models/general_model.dart';
import 'package:Al_Arqam/view/auth/auth_bloc/auth_bloc.dart';

import '../../core/handling_error/handling_exception_manager.dart';
import '../../core/resources/type_def.dart';
import '../../models/auth/data_source/auth_data_source.dart';
import '../../models/auth/login_model.dart';

abstract class AuthController {
  DataResponse<GeneralModel> forgetPassword(BodyMap body);
  DataResponse<SignUpModel> signUp(BodyMap body);
  DataResponse<LoginModel> login(BodyMap body);
  DataResponse<VerifyEmailModel> verifyEmail(BodyMap body);
  DataResponse<GeneralModel> resendCode(BodyMap body);
  DataResponse<GeneralModel> resetPassword(BodyMap body);
  DataResponse<GeneralModel> confirmPasswordCode(BodyMap body);
}

class AuthControllerImp
    with HandlingExceptionManager
    implements AuthController {
  final authDataSource = AuthDataSource();

  @override
  DataResponse<GeneralModel> forgetPassword(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return authDataSource.forgetPassword(body);
      },
    );
    return result;
  }

  @override
  DataResponse<SignUpModel> signUp(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return authDataSource.signUp(body);
      },
    );
    return result;
  }

  @override
  DataResponse<LoginModel> login(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return authDataSource.login(body);
      },
    );
    return result;
  }

  @override
  DataResponse<GeneralModel> resendCode(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return authDataSource.resendCode(body);
      },
    );
    return result;
  }

  @override
  DataResponse<GeneralModel> resetPassword(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return authDataSource.resetPassword(body);
      },
    );
    return result;
  }

  @override
  DataResponse<VerifyEmailModel> verifyEmail(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return authDataSource.verifyEmail(body);
      },
    );
    return result;
  }

  @override
  DataResponse<GeneralModel> confirmPasswordCode(BodyMap body) {
    var result = wrapHandling(
      tryCall: () {
        return authDataSource.confirmPasswordCode(body);
      },
    );
    return result;
  }
}
