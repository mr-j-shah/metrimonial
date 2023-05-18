// To parse this JSON data, do
//
//     final signOutResponse = signOutResponseFromJson(jsonString);

import 'dart:convert';

SignOutResponse signOutResponseFromJson(String str) =>
    SignOutResponse.fromJson(json.decode(str));

String signOutResponseToJson(SignOutResponse data) =>
    json.encode(data.toJson());

class SignOutResponse {
  SignOutResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      SignOutResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  SignOutResponse.initialState()
      : result = false,
        message = '';
}
