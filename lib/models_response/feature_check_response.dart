// To parse this JSON data, do
//
//     final featureCheckResponse = featureCheckResponseFromJson(jsonString);

import 'dart:convert';

FeatureCheckResponse featureCheckResponseFromJson(String str) =>
    FeatureCheckResponse.fromJson(json.decode(str));

String featureCheckResponseToJson(FeatureCheckResponse data) =>
    json.encode(data.toJson());

class FeatureCheckResponse {
  FeatureCheckResponse({
    this.result,
    this.data,
  });

  bool result;
  Data data;

  factory FeatureCheckResponse.fromJson(Map<String, dynamic> json) =>
      FeatureCheckResponse(
        result: json["result"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.googleLogin,
    this.facebookLogin,
    this.twitterLogin,
    this.forceHttps,
    this.maintenanceMode,
    this.walletSystem,
    this.fullProfileShow,
    this.profilePictureApproval,
    this.galleryImagePrivacy,
    this.profilePicturePrivacy,
    this.memberMinAge,
    this.emailVerification,
    this.memberApprovalByAdmin,
    this.defaultCurrency,
  });

  bool googleLogin;
  bool facebookLogin;
  bool twitterLogin;
  bool forceHttps;
  bool maintenanceMode;
  bool walletSystem;
  bool fullProfileShow;
  bool profilePictureApproval;
  String galleryImagePrivacy;
  String profilePicturePrivacy;
  dynamic memberMinAge;
  bool emailVerification;
  bool memberApprovalByAdmin;
  String defaultCurrency;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        googleLogin: json["google_login"],
        facebookLogin: json["facebook_login"],
        twitterLogin: json["twitter_login"],
        forceHttps: json["force_https"],
        maintenanceMode: json["maintenance_mode"],
        walletSystem: json["wallet_system"],
        fullProfileShow: json["full_profile_show"],
        profilePictureApproval: json["profile_picture_approval"],
        galleryImagePrivacy: json["gallery_image_privacy"],
        profilePicturePrivacy: json["profile_picture_privacy"],
        memberMinAge: json["member_min_age"],
        emailVerification: json["email_verification"],
        memberApprovalByAdmin: json["member_approval_by_admin"],
        defaultCurrency: json["default_currency"],
      );

  Map<String, dynamic> toJson() => {
        "google_login": googleLogin,
        "facebook_login": facebookLogin,
        "twitter_login": twitterLogin,
        "force_https": forceHttps,
        "maintenance_mode": maintenanceMode,
        "wallet_system": walletSystem,
        "full_profile_show": fullProfileShow,
        "profile_picture_approval": profilePictureApproval,
        "gallery_image_privacy": galleryImagePrivacy,
        "profile_picture_privacy": profilePicturePrivacy,
        "member_min_age": memberMinAge,
        "email_verification": emailVerification,
        "member_approval_by_admin": memberApprovalByAdmin,
        "default_currency": defaultCurrency,
      };
}
