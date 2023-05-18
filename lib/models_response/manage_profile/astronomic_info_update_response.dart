// To parse this JSON data, do
//
//     final astronomicInfoUpdateResponse = astronomicInfoUpdateResponseFromJson(jsonString);

import 'dart:convert';

AstronomicInfoUpdateResponse astronomicInfoUpdateResponseFromJson(String str) =>
    AstronomicInfoUpdateResponse.fromJson(json.decode(str));

String astronomicInfoUpdateResponseToJson(AstronomicInfoUpdateResponse data) =>
    json.encode(data.toJson());

class AstronomicInfoUpdateResponse {
  AstronomicInfoUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory AstronomicInfoUpdateResponse.fromJson(Map<String, dynamic> json) =>
      AstronomicInfoUpdateResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  AstronomicInfoUpdateResponse.initialState()
      : result = false,
        message = '';
}
