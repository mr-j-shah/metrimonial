// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    this.result,
    this.message,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });

  bool result;
  String message;
  String accessToken;
  String tokenType;
  dynamic expiresAt;
  var user;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        result: json["result"],
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: json["expires_at"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.type,
    this.name,
    this.email,
    this.birthday,
    this.height,
    this.maritalStatusId,
    this.avatar,
    this.avatarOriginal,
    this.phone,
  });

  int id;
  String type;
  String name;
  String email;
  var birthday;
  var height;
  MaritalStatusId maritalStatusId;
  String avatar;
  String avatarOriginal;
  String phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        email: json["email"],
        birthday: json["birthday"],
        height: json["height"],
        maritalStatusId: MaritalStatusId.fromJson(json["marital_status_id"]),
        avatar: json["avatar"],
        avatarOriginal: json["avatar_original"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "email": email,
        "birthday": birthday,
        "height": height,
        "marital_status_id": maritalStatusId.toJson(),
        "avatar": avatar,
        "avatar_original": avatarOriginal,
        "phone": phone,
      };
}

class MaritalStatusId {
  MaritalStatusId({
    this.id,
    this.name,
  });

  var id;
  String name;

  factory MaritalStatusId.fromJson(Map<String, dynamic> json) =>
      MaritalStatusId(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
