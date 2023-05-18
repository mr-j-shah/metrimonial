// To parse this JSON data, do
//
//     final spiritualBackgroundUpdateResponse = spiritualBackgroundUpdateResponseFromJson(jsonString);

import 'dart:convert';

SpiritualBackgroundUpdateResponse spiritualBackgroundUpdateResponseFromJson(String str) => SpiritualBackgroundUpdateResponse.fromJson(json.decode(str));

String spiritualBackgroundUpdateResponseToJson(SpiritualBackgroundUpdateResponse data) => json.encode(data.toJson());

class SpiritualBackgroundUpdateResponse {
  SpiritualBackgroundUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory SpiritualBackgroundUpdateResponse.fromJson(Map<String, dynamic> json) => SpiritualBackgroundUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };

  SpiritualBackgroundUpdateResponse.initialState():
      result = false,
      message = '';
}
