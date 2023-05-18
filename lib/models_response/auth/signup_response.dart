// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.message,
    this.result,
  });

  var message;
  bool result;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        message: json["message"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result,
      };

  SignUpResponse.initialState()
      : message = '',
        result = false;
}
