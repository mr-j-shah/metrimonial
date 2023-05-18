// To parse this JSON data, do
//
//     final addShortlistResponse = addShortlistResponseFromJson(jsonString);

import 'dart:convert';

AddShortlistResponse addShortlistResponseFromJson(String str) =>
    AddShortlistResponse.fromJson(json.decode(str));

String addShortlistResponseToJson(AddShortlistResponse data) =>
    json.encode(data.toJson());

class AddShortlistResponse {
  AddShortlistResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory AddShortlistResponse.fromJson(Map<String, dynamic> json) =>
      AddShortlistResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  AddShortlistResponse.initialState()
      : result = false,
        message = '';
}
