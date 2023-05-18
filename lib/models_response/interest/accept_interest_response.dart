// To parse this JSON data, do
//
//     final acceptInterestResponse = acceptInterestResponseFromJson(jsonString);

import 'dart:convert';

AcceptInterestResponse acceptInterestResponseFromJson(String str) =>
    AcceptInterestResponse.fromJson(json.decode(str));

String acceptInterestResponseToJson(AcceptInterestResponse data) =>
    json.encode(data.toJson());

class AcceptInterestResponse {
  AcceptInterestResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory AcceptInterestResponse.fromJson(Map<String, dynamic> json) =>
      AcceptInterestResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };

  AcceptInterestResponse.initialState()
      : result = false,
        message = '';
}
