// To parse this JSON data, do
//
//     final profilePictureViewRequestPostResponse = profilePictureViewRequestPostResponseFromJson(jsonString);

import 'dart:convert';

ProfilePictureViewRequestPostResponse
    profilePictureViewRequestPostResponseFromJson(String str) =>
        ProfilePictureViewRequestPostResponse.fromJson(json.decode(str));

String profilePictureViewRequestPostResponseToJson(
        ProfilePictureViewRequestPostResponse data) =>
    json.encode(data.toJson());

class ProfilePictureViewRequestPostResponse {
  ProfilePictureViewRequestPostResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory ProfilePictureViewRequestPostResponse.fromJson(
          Map<String, dynamic> json) =>
      ProfilePictureViewRequestPostResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };

  ProfilePictureViewRequestPostResponse.initialState()
      : result = false,
        message = '';
}
