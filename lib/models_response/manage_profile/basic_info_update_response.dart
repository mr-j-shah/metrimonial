// To parse this JSON data, do
//
//     final basicInfoResponse = basicInfoResponseFromJson(jsonString);

import 'dart:convert';

BasicInfoResponse basicInfoResponseFromJson(String str) =>
    BasicInfoResponse.fromJson(json.decode(str));

String basicInfoResponseToJson(BasicInfoResponse data) =>
    json.encode(data.toJson());

class BasicInfoResponse {
  BasicInfoResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory BasicInfoResponse.fromJson(Map<String, dynamic> json) =>
      BasicInfoResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  BasicInfoResponse.intialState()
      : result = false,
        message = '';
}
