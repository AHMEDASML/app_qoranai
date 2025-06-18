// To parse this JSON data, do
//
//     final verifyEmailModel = verifyEmailModelFromJson(jsonString);

import 'dart:convert';

VerifyEmailModel verifyEmailModelFromJson(String str) => VerifyEmailModel.fromJson(json.decode(str));

String verifyEmailModelToJson(VerifyEmailModel data) => json.encode(data.toJson());

class VerifyEmailModel {
    bool? success;
    String? message;
    User? user;

    VerifyEmailModel({
        this.success,
        this.message,
        this.user,
    });

    VerifyEmailModel copyWith({
        bool? success,
        String? message,
        User? user,
    }) => 
        VerifyEmailModel(
            success: success ?? this.success,
            message: message ?? this.message,
            user: user ?? this.user,
        );

    factory VerifyEmailModel.fromJson(Map<String, dynamic> json) => VerifyEmailModel(
        success: json["success"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user?.toJson(),
    };
}

class User {
    String? id;
    String? username;
    String? email;
    dynamic mobile;
    int? idCard;
    bool? isAdmin;
    bool? isVerified;
    DateTime? lastLogin;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    User({
        this.id,
        this.username,
        this.email,
        this.mobile,
        this.idCard,
        this.isAdmin,
        this.isVerified,
        this.lastLogin,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    User copyWith({
        String? id,
        String? username,
        String? email,
        dynamic mobile,
        int? idCard,
        bool? isAdmin,
        bool? isVerified,
        DateTime? lastLogin,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? v,
    }) => 
        User(
            id: id ?? this.id,
            username: username ?? this.username,
            email: email ?? this.email,
            mobile: mobile ?? this.mobile,
            idCard: idCard ?? this.idCard,
            isAdmin: isAdmin ?? this.isAdmin,
            isVerified: isVerified ?? this.isVerified,
            lastLogin: lastLogin ?? this.lastLogin,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            v: v ?? this.v,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        mobile: json["mobile"],
        idCard: json["id_card"],
        isAdmin: json["isAdmin"],
        isVerified: json["isVerified"],
        lastLogin: json["lastLogin"] == null ? null : DateTime.parse(json["lastLogin"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "mobile": mobile,
        "id_card": idCard,
        "isAdmin": isAdmin,
        "isVerified": isVerified,
        "lastLogin": lastLogin?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
