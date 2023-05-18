// To parse this JSON data, do
//
//     final partnerExpectationUpdateResponse = partnerExpectationUpdateResponseFromJson(jsonString);

import 'dart:convert';

PartnerExpectationUpdateResponse partnerExpectationUpdateResponseFromJson(String str) => PartnerExpectationUpdateResponse.fromJson(json.decode(str));

String partnerExpectationUpdateResponseToJson(PartnerExpectationUpdateResponse data) => json.encode(data.toJson());

class PartnerExpectationUpdateResponse {
  PartnerExpectationUpdateResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory PartnerExpectationUpdateResponse.fromJson(Map<String, dynamic> json) => PartnerExpectationUpdateResponse(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
  };
  PartnerExpectationUpdateResponse.initialState():
      result = false,
      message = '';
}
