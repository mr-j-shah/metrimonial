// To parse this JSON data, do
//
//     final removeFromShortlistResponse = removeFromShortlistResponseFromJson(jsonString);

import 'dart:convert';

RemoveFromShortlistResponse removeFromShortlistResponseFromJson(String str) =>
    RemoveFromShortlistResponse.fromJson(json.decode(str));

String removeFromShortlistResponseToJson(RemoveFromShortlistResponse data) =>
    json.encode(data.toJson());

class RemoveFromShortlistResponse {
  RemoveFromShortlistResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory RemoveFromShortlistResponse.fromJson(Map<String, dynamic> json) =>
      RemoveFromShortlistResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  RemoveFromShortlistResponse.initialState()
      : result = false,
        message = '';
}
