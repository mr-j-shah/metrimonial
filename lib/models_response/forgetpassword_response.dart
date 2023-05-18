// To parse this JSON data, do
//
//     final forgetPasswordResponse = forgetPasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgetPasswordResponse forgetPasswordResponseFromJson(String str) => ForgetPasswordResponse.fromJson(json.decode(str));

String forgetPasswordResponseToJson(ForgetPasswordResponse data) => json.encode(data.toJson());

class ForgetPasswordResponse {
  ForgetPasswordResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };



ForgetPasswordResponse.initialState()
      : result = false,
        message = '';
}
