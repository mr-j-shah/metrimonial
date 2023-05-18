// To parse this JSON data, do
//
//     final contactGetResponse = contactGetResponseFromJson(jsonString);

import 'dart:convert';

ContactGetResponse contactGetResponseFromJson(String str) =>
    ContactGetResponse.fromJson(json.decode(str));

String contactGetResponseToJson(ContactGetResponse data) =>
    json.encode(data.toJson());

class ContactGetResponse {
  ContactGetResponse({
    this.result,
    this.data,
  });

  bool result;
  Data data;

  factory ContactGetResponse.fromJson(Map<String, dynamic> json) =>
      ContactGetResponse(
        result: json["result"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data.toJson(),
      };

  ContactGetResponse.initialState()
      : data = Data.initialState(),
        result = false;
}

class Data {
  Data({
    this.email,
  });

  String email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };

  Data.initialState() : email = '';
}
