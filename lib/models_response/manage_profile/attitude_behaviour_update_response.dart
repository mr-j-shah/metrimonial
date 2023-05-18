// To parse this JSON data, do
//
//     final attributeBehaviourUpdateResponse = attributeBehaviourUpdateResponseFromJson(jsonString);

import 'dart:convert';

AttitudeBehaviourUpdateResponse attitudeBehaviourUpdateResponseFromJson(
        String str) =>
    AttitudeBehaviourUpdateResponse.fromJson(json.decode(str));

String attitudeBehaviourUpdateResponseToJson(
        AttitudeBehaviourUpdateResponse data) =>
    json.encode(data.toJson());

class AttitudeBehaviourUpdateResponse {
  AttitudeBehaviourUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory AttitudeBehaviourUpdateResponse.fromJson(
          Map<String, dynamic> json) =>
      AttitudeBehaviourUpdateResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  AttitudeBehaviourUpdateResponse.initialState()
      : result = false,
        message = '';
}
