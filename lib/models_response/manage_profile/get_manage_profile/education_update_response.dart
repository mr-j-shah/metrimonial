// To parse this JSON data, do
//
//     final educationUpdateResponse = educationUpdateResponseFromJson(jsonString);

import 'dart:convert';

EducationUpdateResponse educationUpdateResponseFromJson(String str) =>
    EducationUpdateResponse.fromJson(json.decode(str));

String educationUpdateResponseToJson(EducationUpdateResponse data) =>
    json.encode(data.toJson());

class EducationUpdateResponse {
  EducationUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory EducationUpdateResponse.fromJson(Map<String, dynamic> json) =>
      EducationUpdateResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };

  EducationUpdateResponse.initialState()
      : result = false,
        message = '';
}
