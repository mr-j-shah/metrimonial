// To parse this JSON data, do
//
//     final introductionUpdateResponse = introductionUpdateResponseFromJson(jsonString);

import 'dart:convert';

IntroductionUpdateResponse introductionUpdateResponseFromJson(String str) => IntroductionUpdateResponse.fromJson(json.decode(str));

String introductionUpdateResponseToJson(IntroductionUpdateResponse data) => json.encode(data.toJson());

class IntroductionUpdateResponse {
  IntroductionUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory IntroductionUpdateResponse.fromJson(Map<String, dynamic> json) => IntroductionUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };
  IntroductionUpdateResponse.initialState():
      result = false,
      message = '';
}
