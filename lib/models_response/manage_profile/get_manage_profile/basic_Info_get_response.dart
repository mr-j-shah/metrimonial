// To parse this JSON data, do
//
//     final basicInfoGetResponse = basicInfoGetResponseFromJson(jsonString);

import 'dart:convert';

BasicInfoGetResponse basicInfoGetResponseFromJson(String str) =>
    BasicInfoGetResponse.fromJson(json.decode(str));

String basicInfoGetResponseToJson(BasicInfoGetResponse data) =>
    json.encode(data.toJson());

class BasicInfoGetResponse {
  BasicInfoGetResponse({
    this.data,
    this.result,
  });

  Data data;
  bool result;

  factory BasicInfoGetResponse.fromJson(Map<String, dynamic> json) =>
      BasicInfoGetResponse(
        data: Data.fromJson(json["data"]),
        result: json["result"],
      );

  Map<String, dynamic> toJson() =>
      {
        "data": data.toJson(),
        "result": result,
      };

  BasicInfoGetResponse.initialState()
      : data = Data.initialState(),
        result = false;
}

// class Data {
//   Data({
//     this.firsName,
//     this.lastName,
//     this.dateOfBirth,
//     this.onbehalf,
//     this.noOfChildren,
//     this.gender,
//     this.phone,
//     this.maritialStatus,
//     this.photo,
//   });
//
//   String firsName;
//   String lastName;
//   DateTime dateOfBirth;
//   Onbehalf onbehalf;
//   dynamic noOfChildren;
//   String gender;
//   String phone;
//   String maritialStatus;
//   String photo;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         firsName: json["firs_name"],
//         lastName: json["last_name"],
//         dateOfBirth: DateTime.parse(json["date_of_birth"]),
//         onbehalf: Onbehalf.fromJson(json["onbehalf"]),
//         noOfChildren: json["no_of_children"],
//         gender: json["gender"],
//         phone: json["phone"],
//         maritialStatus: json["maritial_status"],
//         photo: json["photo"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "firs_name": firsName,
//         "last_name": lastName,
//         "date_of_birth": dateOfBirth.toIso8601String(),
//         "onbehalf": onbehalf.toJson(),
//         "no_of_children": noOfChildren,
//         "gender": gender,
//         "phone": phone,
//         "maritial_status": maritialStatus,
//         "photo": photo,
//       };
//
//   Data.initialState()
//       : firsName = '',
//         lastName = '',
//         dateOfBirth = DateTime.now(),
//         onbehalf = Onbehalf.initialState(),
//         gender = '',
//         phone = '',
//         maritialStatus = '',
//         photo = '';
// }
class Data {
  Data({
    this.firsName,
    this.lastName,
    this.dateOfBirth,
    this.onbehalf,
    this.noOfChildren,
    this.gender,
    this.phone,
    this.maritialStatus,
    this.photo,
  });

  String firsName;
  String lastName;
  DateTime dateOfBirth;
  dynamic onbehalf;
  dynamic noOfChildren;
  dynamic gender;
  dynamic phone;
  dynamic maritialStatus;
  dynamic photo;

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        firsName: json["firs_name"],
        lastName: json["last_name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        onbehalf: Onbehalf.fromJson(json["onbehalf"]),
        noOfChildren: json["no_of_children"],
        gender: json["gender"],
        phone: json["phone"],
        maritialStatus: json["maritial_status"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() =>
      {
        "firs_name": firsName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "onbehalf": onbehalf.toJson(),
        "no_of_children": noOfChildren,
        "gender": gender,
        "phone": phone,
        "maritial_status": maritialStatus,
        "photo": photo,
      };

  Data.initialState()
      :
        firsName = '',
        lastName = '',
        dateOfBirth = DateTime.now(),
        onbehalf = Onbehalf.initialState(),
        noOfChildren='',
        gender='',
        phone = '',
        maritialStatus = '',
        photo = '';
}

class Onbehalf {
  Onbehalf({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Onbehalf.fromJson(Map<String, dynamic> json) =>
      Onbehalf(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
      };

  Onbehalf.initialState()
      : id = 0,
        name = '';
}
