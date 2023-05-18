// To parse this JSON data, do
//
//     final galleryImagesResponse = galleryImagesResponseFromJson(jsonString);

import 'dart:convert';

GalleryImagesResponse galleryImagesResponseFromJson(String str) =>
    GalleryImagesResponse.fromJson(json.decode(str));

String galleryImagesResponseToJson(GalleryImagesResponse data) =>
    json.encode(data.toJson());

class GalleryImagesResponse {
  GalleryImagesResponse({
    this.data,
    this.result,
  });

  List<Data> data;
  bool result;

  factory GalleryImagesResponse.fromJson(Map<String, dynamic> json) =>
      GalleryImagesResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "result": result == null ? null : result,
      };
}

class Data {
  Data({
    this.imagePath,
  });

  String imagePath;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imagePath: json["image_path"] == null ? null : json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "image_path": imagePath == null ? null : imagePath,
      };
}
