// To parse this JSON data, do
//
//     final residencyInfoUpdateResponse = residencyInfoUpdateResponseFromJson(jsonString);

import 'dart:convert';

ResidencyInfoUpdateResponse residencyInfoUpdateResponseFromJson(String str) => ResidencyInfoUpdateResponse.fromJson(json.decode(str));

String residencyInfoUpdateResponseToJson(ResidencyInfoUpdateResponse data) => json.encode(data.toJson());

class ResidencyInfoUpdateResponse {
  ResidencyInfoUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory ResidencyInfoUpdateResponse.fromJson(Map<String, dynamic> json) => ResidencyInfoUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };

  ResidencyInfoUpdateResponse.initialState():
      result = false,
      message = '';
}
