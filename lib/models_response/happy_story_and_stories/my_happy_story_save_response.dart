// To parse this JSON data, do
//
//     final myHappyStorySaveResponse = myHappyStorySaveResponseFromJson(jsonString);

import 'dart:convert';

MyHappyStorySaveResponse myHappyStorySaveResponseFromJson(String str) =>
    MyHappyStorySaveResponse.fromJson(json.decode(str));

String myHappyStorySaveResponseToJson(MyHappyStorySaveResponse data) =>
    json.encode(data.toJson());

class MyHappyStorySaveResponse {
  MyHappyStorySaveResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory MyHappyStorySaveResponse.fromJson(Map<String, dynamic> json) =>
      MyHappyStorySaveResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  MyHappyStorySaveResponse.initialState()
      : result = false,
        message = '';
}
