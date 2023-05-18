// To parse this JSON data, do
//
//     final educationResponse = educationResponseFromJson(jsonString);

import 'dart:convert';

EducationResponse educationResponseFromJson(String str) =>
    EducationResponse.fromJson(json.decode(str));

String educationResponseToJson(EducationResponse data) =>
    json.encode(data.toJson());

class EducationResponse {
  EducationResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory EducationResponse.fromJson(Map<String, dynamic> json) =>
      EducationResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  EducationResponse.initialState()
      : result = false,
        message = '';
}
