// To parse this JSON data, do
//
//     final attitudeBehaviorGetResponse = attitudeBehaviorGetResponseFromJson(jsonString);

import 'dart:convert';

AttitudeBehaviorGetResponse attitudeBehaviorGetResponseFromJson(String str) =>
    AttitudeBehaviorGetResponse.fromJson(json.decode(str));

String attitudeBehaviorGetResponseToJson(AttitudeBehaviorGetResponse data) =>
    json.encode(data.toJson());

class AttitudeBehaviorGetResponse {
  AttitudeBehaviorGetResponse({
    this.data,
    this.result,

  });

  Data data;
  bool result;

  factory AttitudeBehaviorGetResponse.fromJson(Map<String, dynamic> json) =>
      AttitudeBehaviorGetResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
    "result": result == null ? null : result,
      };

  AttitudeBehaviorGetResponse.initialState() : data = Data.initialState(), result = false;
}

class Data {
  Data({
    this.affection,
    this.humor,
    this.politicalViews,
    this.religiousService,
  });

  dynamic affection;
  dynamic humor;
  dynamic politicalViews;
  dynamic religiousService;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        affection: json["affection"],
        humor: json["humor"],
        politicalViews: json["political_views"],
        religiousService: json["religious_service"],
      );

  Map<String, dynamic> toJson() => {
        "affection": affection,
        "humor": humor,
        "political_views": politicalViews,
        "religious_service": religiousService,
      };

  Data.initialState()
      : affection = '',
        humor = '',
        politicalViews = '',
        religiousService = '';
}
