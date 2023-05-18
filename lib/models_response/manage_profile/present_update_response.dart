// To parse this JSON data, do
//
//     final presentUpdateResponse = presentUpdateResponseFromJson(jsonString);

import 'dart:convert';

PresentUpdateResponse presentUpdateResponseFromJson(String str) =>
    PresentUpdateResponse.fromJson(json.decode(str));

String presentUpdateResponseToJson(PresentUpdateResponse data) =>
    json.encode(data.toJson());

class PresentUpdateResponse {
  PresentUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory PresentUpdateResponse.fromJson(Map<String, dynamic> json) =>
      PresentUpdateResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  PresentUpdateResponse.initialState()
      : result = false,
        message = '';
}
