// To parse this JSON data, do
//
//     final home9Response = home9ResponseFromJson(jsonString);

import 'dart:convert';

ExploreResponse exploreResponseFromJson(String str) =>
    ExploreResponse.fromJson(json.decode(str));

String exploreResponseToJson(ExploreResponse data) =>
    json.encode(data.toJson());

class ExploreResponse {
  ExploreResponse({
    this.result,
    this.data,
  });

  bool result;
  ExploreData data;

  factory ExploreResponse.fromJson(Map<String, dynamic> json) =>
      ExploreResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null ? null : ExploreData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null ? null : data.toJson(),
      };
}

class ExploreData {
  ExploreData({
    this.sliderImages,
    this.newMembers,
    this.premiumMembers,
    this.banner,
    this.howItWorks,
    this.trustedByMillions,
    this.happyStories,
    this.packages,
    this.reviews,
    this.blogs,
  });

  List<SliderImage> sliderImages;
  List<Member> newMembers;
  List<Member> premiumMembers;
  List<Banner> banner;
  HowItWorks howItWorks;
  List<TrustedByMillion> trustedByMillions;
  List<HappyStory> happyStories;
  List<Package> packages;
  Reviews reviews;
  List<Blog> blogs;

  factory ExploreData.fromJson(Map<String, dynamic> json) => ExploreData(
        sliderImages: json["slider_images"] == null
            ? null
            : List<SliderImage>.from(
                json["slider_images"].map((x) => SliderImage.fromJson(x))),
        newMembers: json["new_members"] == null
            ? null
            : List<Member>.from(
                json["new_members"].map((x) => Member.fromJson(x))),
        premiumMembers: json["premium_members"] == null
            ? null
            : List<Member>.from(
                json["premium_members"].map((x) => Member.fromJson(x))),
        banner: json["banner"] == null
            ? null
            : List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
        howItWorks: json["how_it_works"] == null
            ? null
            : HowItWorks.fromJson(json["how_it_works"]),
        trustedByMillions: json["trusted_by_millions"] == null
            ? null
            : List<TrustedByMillion>.from(json["trusted_by_millions"]
                .map((x) => TrustedByMillion.fromJson(x))),
        happyStories: json["happy_stories"] == null
            ? null
            : List<HappyStory>.from(
                json["happy_stories"].map((x) => HappyStory.fromJson(x))),
        packages: json["packages"] == null
            ? null
            : List<Package>.from(
                json["packages"].map((x) => Package.fromJson(x))),
        reviews: json["reviews"].runtimeType == List
            ? null
            : Reviews.fromJson(json["reviews"]),
        blogs: json["blogs"] == null
            ? null
            : List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider_images": sliderImages == null
            ? null
            : List<dynamic>.from(sliderImages.map((x) => x.toJson())),
        "new_members": newMembers == null
            ? null
            : List<dynamic>.from(newMembers.map((x) => x.toJson())),
        "premium_members": premiumMembers == null
            ? null
            : List<dynamic>.from(premiumMembers.map((x) => x.toJson())),
        "banner": banner == null
            ? null
            : List<dynamic>.from(banner.map((x) => x.toJson())),
        "how_it_works": howItWorks == null ? null : howItWorks.toJson(),
        "trusted_by_millions": trustedByMillions == null
            ? null
            : List<dynamic>.from(trustedByMillions.map((x) => x.toJson())),
        "happy_stories": happyStories == null
            ? null
            : List<dynamic>.from(happyStories.map((x) => x.toJson())),
        "packages": packages == null
            ? null
            : List<dynamic>.from(packages.map((x) => x.toJson())),
        "reviews": reviews == null ? null : reviews.toJson(),
        "blogs": blogs == null
            ? null
            : List<dynamic>.from(blogs.map((x) => x.toJson())),
      };
}

class Banner {
  Banner({
    this.link,
    this.photo,
  });

  String link;
  String photo;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        link: json["link"] == null ? null : json["link"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "link": link == null ? null : link,
        "photo": photo == null ? null : photo,
      };
}

class Blog {
  Blog({
    this.id,
    this.title,
    this.slug,
    this.banner,
    this.categoryName,
    this.shortDescription,
    this.description,
  });

  int id;
  String title;
  String slug;
  String banner;
  String categoryName;
  String shortDescription;
  String description;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        slug: json["slug"] == null ? null : json["slug"],
        banner: json["banner"] == null ? null : json["banner"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "slug": slug == null ? null : slug,
        "banner": banner == null ? null : banner,
        "category_name": categoryName == null ? null : categoryName,
        "short_description": shortDescription == null ? null : shortDescription,
        "description": description == null ? null : description,
      };
}

class HappyStory {
  HappyStory({
    this.id,
    this.userId,
    this.packageUpdateAlert,
    this.userFirstName,
    this.userLastName,
    this.partnerName,
    this.title,
    this.details,
    this.date,
    this.thumbImg,
    this.photos,
    this.videoProvider,
    this.videoLink,
  });

  int id;
  int userId;
  bool packageUpdateAlert;
  String userFirstName;
  String userLastName;
  String partnerName;
  String title;
  String details;
  String date;
  String thumbImg;
  List<String> photos;
  String videoProvider;
  String videoLink;

  factory HappyStory.fromJson(Map<String, dynamic> json) => HappyStory(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        packageUpdateAlert: json["package_update_alert"] == null
            ? null
            : json["package_update_alert"],
        userFirstName:
            json["user_first_name"] == null ? null : json["user_first_name"],
        userLastName:
            json["user_last_name"] == null ? null : json["user_last_name"],
        partnerName: json["partner_name"] == null ? null : json["partner_name"],
        title: json["title"] == null ? null : json["title"],
        details: json["details"] == null ? null : json["details"],
        date: json["date"] == null ? null : json["date"],
        thumbImg: json["thumb_img"] == null ? null : json["thumb_img"],
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
        videoProvider:
            json["video_provider"] == null ? null : json["video_provider"],
        videoLink: json["video_link"] == null ? null : json["video_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "package_update_alert":
            packageUpdateAlert == null ? null : packageUpdateAlert,
        "user_first_name": userFirstName == null ? null : userFirstName,
        "user_last_name": userLastName == null ? null : userLastName,
        "partner_name": partnerName == null ? null : partnerName,
        "title": title == null ? null : title,
        "details": details == null ? null : details,
        "date": date == null ? null : date,
        "thumb_img": thumbImg == null ? null : thumbImg,
        "photos":
            photos == null ? null : List<dynamic>.from(photos.map((x) => x)),
        "video_provider": videoProvider == null ? null : videoProvider,
        "video_link": videoLink == null ? null : videoLink,
      };
}

class HowItWorks {
  HowItWorks({
    this.howItWorksTitle,
    this.howItWorksSubTitle,
    this.items,
  });

  String howItWorksTitle;
  String howItWorksSubTitle;
  List<HowItWorksItem> items;

  factory HowItWorks.fromJson(Map<String, dynamic> json) => HowItWorks(
        howItWorksTitle: json["how_it_works_title"] == null
            ? null
            : json["how_it_works_title"],
        howItWorksSubTitle: json["how_it_works_sub_title"] == null
            ? null
            : json["how_it_works_sub_title"],
        items: json["items"] == null
            ? null
            : List<HowItWorksItem>.from(
                json["items"].map((x) => HowItWorksItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "how_it_works_title": howItWorksTitle == null ? null : howItWorksTitle,
        "how_it_works_sub_title":
            howItWorksSubTitle == null ? null : howItWorksSubTitle,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class HowItWorksItem {
  HowItWorksItem({
    this.step,
    this.title,
    this.subtitle,
    this.icon,
  });

  int step;
  String title;
  String subtitle;
  String icon;

  factory HowItWorksItem.fromJson(Map<String, dynamic> json) => HowItWorksItem(
        step: json["step"] == null ? null : json["step"],
        title: json["title"] == null ? null : json["title"],
        subtitle: json["subtitle"] == null ? null : json["subtitle"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "step": step == null ? null : step,
        "title": title == null ? null : title,
        "subtitle": subtitle == null ? null : subtitle,
        "icon": icon == null ? null : icon,
      };
}

class Member {
  Member({
    this.userId,
    this.code,
    this.membership,
    this.name,
    this.photo,
    this.age,
    this.country,
    this.height,
    this.packageUpdateAlert,
    this.interestStatus,
    this.interestText,
    this.shortlistStatus,
    this.shortlistText,
    this.reportStatus,
    this.profileViewRequestStatus,
    this.galleryViewRequestStatus,
  });

  int userId;
  String code;
  int membership;
  String name;
  String photo;
  var age;
  String country;
  dynamic height;
  bool packageUpdateAlert;
  var interestStatus;
  String interestText;
  int shortlistStatus;
  String shortlistText;
  bool reportStatus;
  bool profileViewRequestStatus;
  bool galleryViewRequestStatus;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        userId: json["user_id"] == null ? null : json["user_id"],
        code: json["code"] == null ? null : json["code"],
        membership: json["membership"] == null ? null : json["membership"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
        age: json["age"] == null ? null : json["age"],
        country: json["country"] == null ? null : json["country"],
        height: json["height"],
        packageUpdateAlert: json["package_update_alert"] == null
            ? null
            : json["package_update_alert"],
        interestStatus:
            json["interest_status"] == null ? null : json["interest_status"],
        interestText:
            json["interest_text"] == null ? null : json["interest_text"],
        shortlistStatus:
            json["shortlist_status"] == null ? null : json["shortlist_status"],
        shortlistText:
            json["shortlist_text"] == null ? null : json["shortlist_text"],
        reportStatus:
            json["report_status"] == null ? null : json["report_status"],
        profileViewRequestStatus: json["profile_view_resquest_status"],
        galleryViewRequestStatus: json["gallery_view_resquest_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "code": code == null ? null : code,
        "membership": membership == null ? null : membership,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "age": age == null ? null : age,
        "country": country == null ? null : country,
        "height": height,
        "package_update_alert":
            packageUpdateAlert == null ? null : packageUpdateAlert,
        "interest_status": interestStatus == null ? null : interestStatus,
        "interest_text": interestText == null ? null : interestText,
        "shortlist_status": shortlistStatus == null ? null : shortlistStatus,
        "shortlist_text": shortlistText == null ? null : shortlistText,
        "report_status": reportStatus == null ? null : reportStatus,
        "profile_view_resquest_status": profileViewRequestStatus,
        "gallery_view_resquest_status": galleryViewRequestStatus,
      };
}

class Package {
  Package({
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

  factory Package.fromJson(Map<String, dynamic> json) => Package(
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

class Reviews {
  Reviews({
    this.bgImage,
    this.items,
  });

  String bgImage;
  List<ReviewsItem> items;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        bgImage: json["bg_image"] == null ? null : json["bg_image"],
        items: json["items"] == null
            ? null
            : List<ReviewsItem>.from(
                json["items"].map((x) => ReviewsItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bg_image": bgImage == null ? null : bgImage,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ReviewsItem {
  ReviewsItem({
    this.image,
    this.review,
  });

  String image;
  String review;

  factory ReviewsItem.fromJson(Map<String, dynamic> json) => ReviewsItem(
        image: json["image"] == null ? null : json["image"],
        review: json["review"] == null ? null : json["review"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "review": review == null ? null : review,
      };
}

class SliderImage {
  SliderImage({
    this.image,
  });

  String image;

  factory SliderImage.fromJson(Map<String, dynamic> json) => SliderImage(
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
      };
}

class TrustedByMillion {
  TrustedByMillion({
    this.title,
    this.icon,
  });

  String title;
  String icon;

  factory TrustedByMillion.fromJson(Map<String, dynamic> json) =>
      TrustedByMillion(
        title: json["title"] == null ? null : json["title"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "icon": icon == null ? null : icon,
      };
}
