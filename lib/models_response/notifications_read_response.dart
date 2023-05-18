// To parse this JSON data, do
//
//     final readNotificationsResponse = readNotificationsResponseFromJson(jsonString);

import 'dart:convert';

ReadNotificationsResponse readNotificationsResponseFromJson(String str) =>
    ReadNotificationsResponse.fromJson(json.decode(str));

String readNotificationsResponseToJson(ReadNotificationsResponse data) =>
    json.encode(data.toJson());

class ReadNotificationsResponse {
  ReadNotificationsResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory ReadNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      ReadNotificationsResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  ReadNotificationsResponse.initialState()
      : result = false,
        message = '';
}
