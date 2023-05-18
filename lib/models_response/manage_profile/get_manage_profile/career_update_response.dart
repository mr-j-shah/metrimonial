// To parse this JSON data, do
//
//     final educationUpdateResponse = educationUpdateResponseFromJson(jsonString);

import 'dart:convert';

CareerUpdateResponse careerUpdateResponseFromJson(String str) =>
    CareerUpdateResponse.fromJson(json.decode(str));

String careerUpdateResponseToJson(CareerUpdateResponse data) =>
    json.encode(data.toJson());

class CareerUpdateResponse {
  CareerUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory CareerUpdateResponse.fromJson(Map<String, dynamic> json) =>
      CareerUpdateResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };

  CareerUpdateResponse.initialState()
      : result = false,
        message = '';
}
