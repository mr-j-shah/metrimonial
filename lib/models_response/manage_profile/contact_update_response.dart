// To parse this JSON data, do
//
//     final contactUpdatetResponse = contactUpdatetResponseFromJson(jsonString);

import 'dart:convert';

ContactUpdatetResponse contactUpdatetResponseFromJson(String str) => ContactUpdatetResponse.fromJson(json.decode(str));

String contactUpdatetResponseToJson(ContactUpdatetResponse data) => json.encode(data.toJson());

class ContactUpdatetResponse {
  ContactUpdatetResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory ContactUpdatetResponse.fromJson(Map<String, dynamic> json) => ContactUpdatetResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };

  ContactUpdatetResponse.initialState():
      result = false,
      message = '';
}
