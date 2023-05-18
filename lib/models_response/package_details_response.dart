// To parse this JSON data, do
//
//     final packageDetailsResponse = packageDetailsResponseFromJson(jsonString);

import 'dart:convert';

PackageDetailsResponse packageDetailsResponseFromJson(String str) =>
    PackageDetailsResponse.fromJson(json.decode(str));

String packageDetailsResponseToJson(PackageDetailsResponse data) =>
    json.encode(data.toJson());

class PackageDetailsResponse {
  PackageDetailsResponse({
    this.result,
    this.data,
  });

  bool result;
  Data data;

  factory PackageDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PackageDetailsResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : data.toJson(),
      };

  PackageDetailsResponse.initialState()
      : result = false,
        data = Data.initialState();
}

class Data {
  Data({
    this.id,
    this.name,
    this.expressInterest,
    this.photoGallery,
    this.contact,
    this.profileImageView,
    this.galleryImageView,
    this.autoProfileMatch,
    this.price,
    this.active,
    this.validity,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  int expressInterest;
  int photoGallery;
  int contact;
  int profileImageView;
  int galleryImageView;
  int autoProfileMatch;
  int price;
  int active;
  int validity;
  int image;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        expressInterest:
            json["express_interest"] == null ? null : json["express_interest"],
        photoGallery:
            json["photo_gallery"] == null ? null : json["photo_gallery"],
        contact: json["contact"] == null ? null : json["contact"],
        profileImageView: json["profile_image_view"] == null
            ? null
            : json["profile_image_view"],
        galleryImageView: json["gallery_image_view"] == null
            ? null
            : json["gallery_image_view"],
        autoProfileMatch: json["auto_profile_match"] == null
            ? null
            : json["auto_profile_match"],
        price: json["price"] == null ? null : json["price"],
        active: json["active"] == null ? null : json["active"],
        validity: json["validity"] == null ? null : json["validity"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "express_interest": expressInterest == null ? null : expressInterest,
        "photo_gallery": photoGallery == null ? null : photoGallery,
        "contact": contact == null ? null : contact,
        "profile_image_view":
            profileImageView == null ? null : profileImageView,
        "gallery_image_view":
            galleryImageView == null ? null : galleryImageView,
        "auto_profile_match":
            autoProfileMatch == null ? null : autoProfileMatch,
        "price": price == null ? null : price,
        "active": active == null ? null : active,
        "validity": validity == null ? null : validity,
        "image": image == null ? null : image,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };

  Data.initialState()
      : id = 0,
        name = '',
        expressInterest = 0,
        photoGallery = 0,
        contact = 0,
        profileImageView = 0,
        galleryImageView = 0,
        autoProfileMatch = 0,
        price = 0,
        active = 0,
        validity = 0,
        image = 0;
}
