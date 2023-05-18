// To parse this JSON data, do
//
//     final physicalAttrUpdateResponse = physicalAttrUpdateResponseFromJson(jsonString);

import 'dart:convert';

PhysicalAttrUpdateResponse physicalAttrUpdateResponseFromJson(String str) => PhysicalAttrUpdateResponse.fromJson(json.decode(str));

String physicalAttrUpdateResponseToJson(PhysicalAttrUpdateResponse data) => json.encode(data.toJson());

class PhysicalAttrUpdateResponse {
  PhysicalAttrUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory PhysicalAttrUpdateResponse.fromJson(Map<String, dynamic> json) => PhysicalAttrUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };
  PhysicalAttrUpdateResponse.initialState():
      result = false,
      message = '';
}
