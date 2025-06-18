import 'dart:convert';

// Function to parse JSON
LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

// Function to convert LoginModel to JSON
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  User? user;
  String? token;

  LoginModel({
    this.success,
    this.message,
    this.user,
    this.token,
  });

  LoginModel copyWith({
    bool? success,
    String? message,
    User? user,
    String? token,
  }) =>
      LoginModel(
        success: success ?? this.success,
        message: message ?? this.message,
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  String? username;
  String? email;
  dynamic mobile; // Keep it dynamic for null values
  String? legalStatus;
  String? idCard;
  String? avatar; // Added avatar based on the JSON
  String? role; // Added role based on the JSON
  List<dynamic> supplications; // Added supplications

  User({
    this.username,
    this.email,
    this.mobile,
    this.legalStatus,
    this.idCard,
    this.avatar,
    this.role,
    this.supplications = const [],
  });

  User copyWith({
    String? username,
    String? email,
    dynamic mobile,
    String? legalStatus,
    String? idCard,
    String? avatar,
    String? role,
    List<dynamic>? supplications,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        legalStatus: legalStatus ?? this.legalStatus,
        idCard: idCard ?? this.idCard,
        avatar: avatar ?? this.avatar,
        role: role ?? this.role,
        supplications: supplications ?? this.supplications,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        mobile: json["mobile"],
        legalStatus: json["legalStatus"],
        idCard: json["id_card"],
        avatar: json["avatar"],
        role: json["role"],
        supplications: json["supplications"] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "mobile": mobile,
        "legalStatus": legalStatus,
        "id_card": idCard,
        "avatar": avatar,
        "role": role,
        "supplications": supplications,
      };
}