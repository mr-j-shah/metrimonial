// To parse this JSON data, do
//
//     final verifyResponse = verifyResponseFromJson(jsonString);

import 'dart:convert';

VerifyResponse verifyResponseFromJson(String str) =>
    VerifyResponse.fromJson(json.decode(str));

String verifyResponseToJson(VerifyResponse data) => json.encode(data.toJson());

class VerifyResponse {
  VerifyResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => VerifyResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  VerifyResponse.initialState()
      : result = false,
        message = '';
}
