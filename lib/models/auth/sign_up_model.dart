// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  bool? success;
  String? message;
  String? verificationCode;

  SignUpModel({
    this.success,
    this.message,
    this.verificationCode,
  });

  SignUpModel copyWith({
    bool? success,
    String? message,
    String? verificationCode,
  }) =>
      SignUpModel(
        success: success ?? this.success,
        message: message ?? this.message,
        verificationCode: verificationCode ?? this.verificationCode,
      );

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        success: json["success"],
        message: json["message"],
        verificationCode: json["verificationCode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "verificationCode": verificationCode,
      };
}
