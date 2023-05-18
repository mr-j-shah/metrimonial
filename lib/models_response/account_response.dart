// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

AccountResponse profileResponseFromJson(String str) =>
    AccountResponse.fromJson(json.decode(str));

String profileResponseToJson(AccountResponse data) =>
    json.encode(data.toJson());

class AccountResponse {
  AccountResponse({
    this.result,
    this.data,
  });

  bool result;
  ProfileData data;

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : data.toJson(),
      };

}

class ProfileData {
  ProfileData({
    this.memberName,
    this.memberEmail,
    this.memberPhoto,
    this.remainingInterest,
    this.remainingContactView,
    this.remainingPhotoGallery,
    this.remainingProfileImageView,
    this.remainingGalleryImageView,
    this.currentPackageInfo,
    this.matchedProfiles,
  });

  String memberName;
  String memberEmail;
  String memberPhoto;
  var remainingInterest;
  var remainingContactView;
  var remainingPhotoGallery;
  var remainingProfileImageView;
  var remainingGalleryImageView;
  CurrentPackageInfo currentPackageInfo;
  List<MatchedProfile> matchedProfiles;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        memberName: json["member_name"] == null ? null : json["member_name"],
        memberEmail: json["member_email"] == null ? null : json["member_email"],
        memberPhoto: json["member_photo"] == null ? null : json["member_photo"],
        remainingInterest: json["remaining_interest"] == null
            ? null
            : json["remaining_interest"],
        remainingContactView: json["remaining_contact_view"] == null
            ? null
            : json["remaining_contact_view"],
        remainingPhotoGallery: json["remaining_photo_gallery"] == null
            ? null
            : json["remaining_photo_gallery"],
        remainingProfileImageView: json["remaining_profile_image_view"] == null
            ? null
            : json["remaining_profile_image_view"],
        remainingGalleryImageView: json["remaining_gallery_image_view"] == null
            ? null
            : json["remaining_gallery_image_view"],
        currentPackageInfo: json["current_package_info"] == null
            ? null
            : CurrentPackageInfo.fromJson(json["current_package_info"]),
        matchedProfiles: json["matched_profiles"] == null
            ? null
            : List<MatchedProfile>.from(json["matched_profiles"]
                .map((x) => MatchedProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "member_name": memberName == null ? null : memberName,
        "member_email": memberEmail == null ? null : memberEmail,
        "member_photo": memberPhoto == null ? null : memberPhoto,
        "remaining_interest":
            remainingInterest == null ? null : remainingInterest,
        "remaining_contact_view":
            remainingContactView == null ? null : remainingContactView,
        "remaining_photo_gallery":
            remainingPhotoGallery == null ? null : remainingPhotoGallery,
        "remaining_profile_image_view": remainingProfileImageView == null
            ? null
            : remainingProfileImageView,
        "remaining_gallery_image_view": remainingGalleryImageView == null
            ? null
            : remainingGalleryImageView,
        "current_package_info":
            currentPackageInfo == null ? null : currentPackageInfo.toJson(),
        "matched_profiles": matchedProfiles == null
            ? null
            : List<dynamic>.from(matchedProfiles.map((x) => x.toJson())),
      };


}

class CurrentPackageInfo {
  CurrentPackageInfo({
    this.packageId,
    this.packageName,
    this.packageExpiry,
  });

  int packageId;
  String packageName;
  String packageExpiry;

  factory CurrentPackageInfo.fromJson(Map<String, dynamic> json) =>
      CurrentPackageInfo(
        packageId: json["package_id"] == null ? null : json["package_id"],
        packageName: json["package_name"] == null ? null : json["package_name"],
        packageExpiry:
            json["package_expiry"] == null ? null : json["package_expiry"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId == null ? null : packageId,
        "package_name": packageName == null ? null : packageName,
        "package_expiry": packageExpiry == null ? null : packageExpiry,
      };

}

class MatchedProfile {
  MatchedProfile({
    this.userId,
    this.code,
    this.membership,
    this.name,
    this.photo,
    this.age,
    this.height,
    this.maritalStatus,
    this.religion,
    this.caste,
    this.subCaste,
    this.reportStatus,
    this.shortlistStatus,
    this.profileViewRequestStatus,
    this.galleryViewRequestStatus,
  });

  int userId;
  String code;
  int membership;
  String name;
  String photo;
  int age;
  dynamic height;
  String maritalStatus;
  String religion;
  String caste;
  String subCaste;
  bool reportStatus;
  int shortlistStatus;
  bool profileViewRequestStatus;
  bool galleryViewRequestStatus;

  factory MatchedProfile.fromJson(Map<String, dynamic> json) => MatchedProfile(
        userId: json["user_id"] == null ? null : json["user_id"],
        code: json["code"] == null ? null : json["code"],
        membership: json["membership"] == null ? null : json["membership"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
        age: json["age"] == null ? null : json["age"],
        height: json["height"],
        maritalStatus:
            json["marital_status"] == null ? null : json["marital_status"],
        religion: json["religion"] == null ? null : json["religion"],
        caste: json["caste"] == null ? null : json["caste"],
        subCaste: json["sub_caste"] == null ? null : json["sub_caste"],
        reportStatus: json["report_status"],
        shortlistStatus: json["shortlist_status"],
        profileViewRequestStatus: json["profile_view_request_status"],
        galleryViewRequestStatus: json["gallery_view_request_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "code": code == null ? null : code,
        "membership": membership == null ? null : membership,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "age": age == null ? null : age,
        "height": height,
        "marital_status": maritalStatus == null ? null : maritalStatus,
        "religion": religion == null ? null : religion,
        "caste": caste == null ? null : caste,
        "sub_caste": subCaste == null ? null : subCaste,
        "report_status": reportStatus,
        "shortlist_status": shortlistStatus,
        "profile_view_request_status": profileViewRequestStatus,
        "gallery_view_request_status": galleryViewRequestStatus,
      };

}
