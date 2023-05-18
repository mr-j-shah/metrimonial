// To parse this JSON data, do
//
//     final deactivateResponse = deactivateResponseFromJson(jsonString);

import 'dart:convert';

DeactivateResponse deactivateResponseFromJson(String str) => DeactivateResponse.fromJson(json.decode(str));

String deactivateResponseToJson(DeactivateResponse data) => json.encode(data.toJson());

class DeactivateResponse {
  DeactivateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory DeactivateResponse.fromJson(Map<String, dynamic> json) => DeactivateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };

  DeactivateResponse.initialState():
      result = false,
      message = '';
}
