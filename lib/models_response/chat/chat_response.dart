// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromJson(jsonString);

import 'dart:convert';

ChatResponse chatResponseFromJson(String str) =>
    ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
  ChatResponse({
    this.data,
    this.result,
    this.matchedProfile,
  });

  List<Data> data;
  bool result;
  ChatResponseMatchedProfile matchedProfile;

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        result: json["result"] == null ? null : json["result"],
        matchedProfile: json["matched_profile"] == null
            ? null
            : ChatResponseMatchedProfile.fromJson(json["matched_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "result": result == null ? null : result,
        "matched_profile":
            matchedProfile == null ? null : matchedProfile.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.active,
    this.blockedByUser,
    this.unseenMessageCount,
    this.memberPhoto,
    this.memberName,
    this.lastMessageTime,
    this.lastMessage,
    this.memberPackage,
  });

  int id;
  int active;
  dynamic blockedByUser;
  int unseenMessageCount;
  String memberPhoto;
  String memberName;
  String lastMessageTime;
  String lastMessage;
  MemberPackage memberPackage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        active: json["active"] == null ? null : json["active"],
        blockedByUser: json["blocked_by_user"],
        unseenMessageCount: json["unseen_message_count"] == null
            ? null
            : json["unseen_message_count"],
        memberPhoto: json["member_photo"] == null ? null : json["member_photo"],
        memberName: json["member_name"] == null ? null : json["member_name"],
        lastMessageTime: json["last_message_time"] == null
            ? null
            : json["last_message_time"],
        lastMessage: json["last_message"] == null ? null : json["last_message"],
        memberPackage: json["member_package"] == null
            ? null
            : MemberPackage.fromJson(json["member_package"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "active": active == null ? null : active,
        "blocked_by_user": blockedByUser,
        "unseen_message_count":
            unseenMessageCount == null ? null : unseenMessageCount,
        "member_photo": memberPhoto == null ? null : memberPhoto,
        "member_name": memberName == null ? null : memberName,
        "last_message_time": lastMessageTime == null ? null : lastMessageTime,
        "last_message": lastMessage == null ? null : lastMessage,
        "member_package": memberPackage == null ? null : memberPackage.toJson(),
      };
}

class MemberPackage {
  MemberPackage({
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

  factory MemberPackage.fromJson(Map<String, dynamic> json) => MemberPackage(
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

class ChatResponseMatchedProfile {
  ChatResponseMatchedProfile({
    this.matchedProfiles,
  });

  List<MatchedProfileElement> matchedProfiles;

  factory ChatResponseMatchedProfile.fromJson(Map<String, dynamic> json) =>
      ChatResponseMatchedProfile(
        matchedProfiles: json["matched_profiles"] == null
            ? null
            : List<MatchedProfileElement>.from(json["matched_profiles"]
                .map((x) => MatchedProfileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "matched_profiles": matchedProfiles == null
            ? null
            : List<dynamic>.from(matchedProfiles.map((x) => x.toJson())),
      };
}

class MatchedProfileElement {
  MatchedProfileElement({
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

  factory MatchedProfileElement.fromJson(Map<String, dynamic> json) =>
      MatchedProfileElement(
        userId: json["user_id"] == null ? null : json["user_id"],
        code: json["code"] == null ? null : json["code"],
        membership: json["membership"] == null ? null : json["membership"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
        age: json["age"] == null ? null : json["age"],
        height: json["height"] == null ? null : json["height"],
        maritalStatus:
            json["marital_status"] == null ? null : json["marital_status"],
        religion: json["religion"] == null ? null : json["religion"],
        caste: json["caste"] == null ? null : json["caste"],
        subCaste: json["sub_caste"] == null ? null : json["sub_caste"],
        reportStatus: json["report_status"],
        shortlistStatus: json["shortlist_status"],
        profileViewRequestStatus: json["profile_view_request_status"] == null
            ? null
            : json["profile_view_request_status"],
        galleryViewRequestStatus: json["gallery_view_request_status"] == null
            ? null
            : json["gallery_view_request_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "code": code == null ? null : code,
        "membership": membership == null ? null : membership,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "age": age == null ? null : age,
        "height": height == null ? null : height,
        "marital_status": maritalStatus == null ? null : maritalStatus,
        "religion": religion == null ? null : religion,
        "caste": caste == null ? null : caste,
        "sub_caste": subCaste == null ? null : subCaste,
        "report_status": reportStatus,
        "shortlist_status": shortlistStatus,
        "profile_view_request_status":
            profileViewRequestStatus == null ? null : profileViewRequestStatus,
        "gallery_view_request_status":
            galleryViewRequestStatus == null ? null : galleryViewRequestStatus,
      };
}
