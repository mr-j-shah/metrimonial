// To parse this JSON data, do
//
//     final familyInfoUpdateResponse = familyInfoUpdateResponseFromJson(jsonString);

import 'dart:convert';

FamilyInfoUpdateResponse familyInfoUpdateResponseFromJson(String str) => FamilyInfoUpdateResponse.fromJson(json.decode(str));

String familyInfoUpdateResponseToJson(FamilyInfoUpdateResponse data) => json.encode(data.toJson());

class FamilyInfoUpdateResponse {
  FamilyInfoUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory FamilyInfoUpdateResponse.fromJson(Map<String, dynamic> json) => FamilyInfoUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };

  FamilyInfoUpdateResponse.initialState():
      result = false,
      message = '';
}
