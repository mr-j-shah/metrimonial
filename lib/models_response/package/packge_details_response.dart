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
    this.data,
    this.result,
  });

  PackageDetails data;
  bool result;

  factory PackageDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PackageDetailsResponse(
        data:
            json["data"] == null ? null : PackageDetails.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "result": result == null ? null : result,
      };
}

class PackageDetails {
  PackageDetails({
    this.packageId,
    this.name,
    this.image,
    this.expressInterest,
    this.photoGallery,
    this.contact,
    this.profileImageView,
    this.galleryImageView,
    this.autoProfileMatch,
    this.price,
    this.validity,
  });

  int packageId;
  String name;
  String image;
  int expressInterest;
  int photoGallery;
  int contact;
  int profileImageView;
  int galleryImageView;
  int autoProfileMatch;
  int price;
  int validity;

  factory PackageDetails.fromJson(Map<String, dynamic> json) => PackageDetails(
        packageId: json["package_id"] == null ? null : json["package_id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
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
        validity: json["validity"] == null ? null : json["validity"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId == null ? null : packageId,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
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
        "validity": validity == null ? null : validity,
      };
}