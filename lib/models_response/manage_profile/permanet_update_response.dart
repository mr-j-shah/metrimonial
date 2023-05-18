// To parse this JSON data, do
//
//     final permanentUpdatetResponse = permanentUpdatetResponseFromJson(jsonString);

import 'dart:convert';

PermanentUpdatetResponse permanentUpdatetResponseFromJson(String str) =>
    PermanentUpdatetResponse.fromJson(json.decode(str));

String permanentUpdatetResponseToJson(PermanentUpdatetResponse data) =>
    json.encode(data.toJson());

class PermanentUpdatetResponse {
  PermanentUpdatetResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory PermanentUpdatetResponse.fromJson(Map<String, dynamic> json) =>
      PermanentUpdatetResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  PermanentUpdatetResponse.initialState()
      : result = false,
        message = '';
}
