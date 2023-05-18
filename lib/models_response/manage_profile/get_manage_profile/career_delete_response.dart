// To parse this JSON data, do
//
//     final educationUpdateResponse = educationUpdateResponseFromJson(jsonString);

import 'dart:convert';

CareerDeleteResponse careerDeleteResponseFromJson(String str) =>
    CareerDeleteResponse.fromJson(json.decode(str));

String careerDeleteResponseToJson(CareerDeleteResponse data) =>
    json.encode(data.toJson());

class CareerDeleteResponse {
  CareerDeleteResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory CareerDeleteResponse.fromJson(Map<String, dynamic> json) =>
      CareerDeleteResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };

  CareerDeleteResponse.initialState()
      : result = false,
        message = '';
}
