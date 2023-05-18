// To parse this JSON data, do
//
//     final hobbiesInterestUpdateResponse = hobbiesInterestUpdateResponseFromJson(jsonString);

import 'dart:convert';

HobbiesInterestUpdateResponse hobbiesInterestUpdateResponseFromJson(String str) => HobbiesInterestUpdateResponse.fromJson(json.decode(str));

String hobbiesInterestUpdateResponseToJson(HobbiesInterestUpdateResponse data) => json.encode(data.toJson());

class HobbiesInterestUpdateResponse {
  HobbiesInterestUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory HobbiesInterestUpdateResponse.fromJson(Map<String, dynamic> json) => HobbiesInterestUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };

  HobbiesInterestUpdateResponse.initialState():
      result = false,
      message = '';
}
