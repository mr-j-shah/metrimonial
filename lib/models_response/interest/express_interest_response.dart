// To parse this JSON data, do
//
//     final expressInterestResponse = expressInterestResponseFromJson(jsonString);

import 'dart:convert';

ExpressInterestResponse expressInterestResponseFromJson(String str) =>
    ExpressInterestResponse.fromJson(json.decode(str));

String expressInterestResponseToJson(ExpressInterestResponse data) =>
    json.encode(data.toJson());

class ExpressInterestResponse {
  ExpressInterestResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory ExpressInterestResponse.fromJson(Map<String, dynamic> json) =>
      ExpressInterestResponse(
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };

  ExpressInterestResponse.initialState()
      : result = false,
        message = '';
}
