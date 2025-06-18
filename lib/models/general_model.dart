// To parse this JSON data, do
//
//     final generalModel = generalModelFromJson(jsonString);

import 'dart:convert';

GeneralModel generalModelFromJson(String str) => GeneralModel.fromJson(json.decode(str));

String generalModelToJson(GeneralModel data) => json.encode(data.toJson());

class GeneralModel {
    bool? success;
    String? message;

    GeneralModel({
        this.success,
        this.message,
    });

    GeneralModel copyWith({
        bool? success,
        String? message,
    }) => 
        GeneralModel(
            success: success ?? this.success,
            message: message ?? this.message,
        );

    factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
