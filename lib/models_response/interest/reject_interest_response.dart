// To parse this JSON data, do
//
//     final rejectInterestResponse = rejectInterestResponseFromJson(jsonString);

import 'dart:convert';

RejectInterestResponse rejectInterestResponseFromJson(String str) =>
    RejectInterestResponse.fromJson(json.decode(str));

String rejectInterestResponseToJson(RejectInterestResponse data) =>
    json.encode(data.toJson());

class RejectInterestResponse {
  RejectInterestResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory RejectInterestResponse.fromJson(Map<String, dynamic> json) =>
      RejectInterestResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };

  RejectInterestResponse.initialState()
      : result = false,
        message = '';
}
