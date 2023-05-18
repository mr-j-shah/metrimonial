// To parse this JSON data, do
//
//     final introductionGetResponse = introductionGetResponseFromJson(jsonString);

import 'dart:convert';

IntroductionGetResponse introductionGetResponseFromJson(String str) =>
    IntroductionGetResponse.fromJson(json.decode(str));

String introductionGetResponseToJson(IntroductionGetResponse data) =>
    json.encode(data.toJson());

class IntroductionGetResponse {
  IntroductionGetResponse({this.data, this.result});

  Data data;
  bool result;

  factory IntroductionGetResponse.fromJson(Map<String, dynamic> json) =>
      IntroductionGetResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "result": result == null ? null : result,
      };

  IntroductionGetResponse.initialState() : data = Data.initialState(), result = false;
}

class Data {
  Data({

    this.introduction,
  });


  String introduction;

  factory Data.fromJson(Map<String, dynamic> json) => Data(

        introduction:
            json["introduction"] == null ? null : json["introduction"],
      );

  Map<String, dynamic> toJson() => {

        "introduction": introduction == null ? null : introduction,
      };

  Data.initialState()
      :
        introduction = '';
}
