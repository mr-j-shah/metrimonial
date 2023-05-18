// To parse this JSON data, do
//
//     final languageUpdateResponse = languageUpdateResponseFromJson(jsonString);

import 'dart:convert';

LanguageUpdateResponse languageUpdateResponseFromJson(String str) => LanguageUpdateResponse.fromJson(json.decode(str));

String languageUpdateResponseToJson(LanguageUpdateResponse data) => json.encode(data.toJson());

class LanguageUpdateResponse {
  LanguageUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory LanguageUpdateResponse.fromJson(Map<String, dynamic> json) => LanguageUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };
  LanguageUpdateResponse.initialState():
      result = false,
      message = '';
}
