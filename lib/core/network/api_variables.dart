import 'dart:developer';

import '../resources/type_def.dart';

class ApiVariables {
  //////////////
  ///General//
  /////////////
  static const scheme = 'https';
  static const host = "api.alarqambh.com";
  static const quranHost = "api.quran.com";

  static Uri _mainUri({
    required String path,
    QueryParams? queryParameters,
  }) {
    final uri = Uri(
      scheme: scheme,
      host: host,
      path: "api/$path",
      queryParameters: queryParameters,
    );
    log(uri.toString());
    return uri;
  }

  static Uri _quranUri({
    required String path,
    QueryParams? queryParameters,
  }) {
    final uri = Uri(
      scheme: scheme,
      host: quranHost,
      path: "api/v4/$path",
      queryParameters: queryParameters,
    );
    log(uri.toString());
    return uri;
  }

//------------------Customer-----------------------
  static Uri _auth({
    required String path,
    QueryParams? queryParameters,
  }) =>
      _mainUri(path: "auth/$path", queryParameters: queryParameters);
  static Uri forgetPassword() => _auth(
        path: "forgot-password",
      );
  static Uri signUp() => _auth(
        path: "signup",
      );
  static Uri login() => _auth(
        path: "login",
      );
  static Uri resetPassword() => _auth(
        path: "reset-password",
      );
  static Uri resendCode() => _auth(
        path: "resend-verification-code",
      );
  static Uri verifyEmail() => _auth(
        path: "verify-email",
      );
  static Uri cnfirmPasswordCode() => _auth(
        path: "confirm-password-code",
      );
  static Uri sendPasswordCode() => _auth(
        path: "send-password-code",
      );
//-------------------Inquiries----------------------------
  static Uri _inquiry({
    required String path,
    QueryParams? queryParameters,
  }) =>
      _mainUri(path: "inquiry/$path", queryParameters: queryParameters);

  static Uri getInquiries({QueryParams? params}) =>
      _inquiry(path: "get-inquiries", queryParameters: params);

  static Uri addInquiry() => _inquiry(path: "add-inquiry");

  static Uri deleteInquiry({required String inquiryId}) =>
      _inquiry(path: "remove-inquiry/$inquiryId");

  static Uri updateInquiry({required String inquiryId}) =>
      _inquiry(path: "update-inquiry/$inquiryId");

  static Uri getCamping() => _mainUri(path: "campaign/get-campaign");

  //TODO =========================Medicins Reminder=================================

  static Uri getAllMedicins() => _mainUri(
        path: "health-record/get-medicines",
      );
  static Uri updateMedicin({
    required String path,
  }) =>
      _mainUri(
        path: path,
      );
  static Uri deleteMedicin({
    required String path,
  }) =>
      _mainUri(
        path: path,
      );
  static Uri addMedicin() => _mainUri(
        path: "health-record/add-medicine",
      );
  //TODO =========================Quran=================================
  static Uri getChapters({QueryParams? params}) =>
      _quranUri(path: "chapters", queryParameters: params);
  static Uri getJuzs() => _quranUri(
        path: "juzs",
      );
  static Uri getVerses({QueryParams? params}) =>
      _quranUri(path: "quran/verses/uthmani", queryParameters: params);
}
