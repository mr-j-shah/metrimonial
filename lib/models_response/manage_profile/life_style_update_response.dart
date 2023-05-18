// To parse this JSON data, do
//
//     final lifeStyleUpdateResponse = lifeStyleUpdateResponseFromJson(jsonString);

import 'dart:convert';

LifeStyleUpdateResponse lifeStyleUpdateResponseFromJson(String str) => LifeStyleUpdateResponse.fromJson(json.decode(str));

String lifeStyleUpdateResponseToJson(LifeStyleUpdateResponse data) => json.encode(data.toJson());

class LifeStyleUpdateResponse {
  LifeStyleUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory LifeStyleUpdateResponse.fromJson(Map<String, dynamic> json) => LifeStyleUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };

  LifeStyleUpdateResponse.initialState():
      result = false,
      message = '';
}
