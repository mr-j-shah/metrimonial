// To parse this JSON data, do
//
//     final educationResponse = educationResponseFromJson(jsonString);

import 'dart:convert';

CareerResponse careerResponseFromJson(String str) =>
    CareerResponse.fromJson(json.decode(str));

String careerResponseToJson(CareerResponse data) =>
    json.encode(data.toJson());

class CareerResponse {
  CareerResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory CareerResponse.fromJson(Map<String, dynamic> json) =>
      CareerResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  CareerResponse.initialState()
      : result = false,
        message = '';
}
