
import 'dart:convert';

ShortlistResponse shortlistResponseFromJson(String str) => ShortlistResponse.fromJson(json.decode(str));

String shortlistResponseToJson(ShortlistResponse data) => json.encode(data.toJson());

class ShortlistResponse {
  ShortlistResponse({
    this.data,
    this.links,
    this.meta,
    this.result,
  });

  List<Datum> data;
  Links links;
  Meta meta;
  bool result;

  factory ShortlistResponse.fromJson(Map<String, dynamic> json) => ShortlistResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "result": result,
  };
}

class Datum {
  Datum({
    this.userId,
    this.packageUpdateAlert,
    this.photo,
    this.name,
    this.age,
    this.religion,
    this.country,
    this.membership,
    this.code,
    this.height,
    this.mothereTongue,
    this.expressInterest,
    this.interestStatus,
    this.shortlistStatus,
    this.reportStatus,
    this.profileViewRequestStatus,
    this.galleryViewRequestStatus,
  });

  int userId;
  bool packageUpdateAlert;
  String photo;
  String name;
  var age;
  String religion;
  String country;
  int membership;
  String code;
  var height;
  String mothereTongue;
  bool expressInterest;
  String interestStatus;
  var shortlistStatus;
  bool reportStatus;
  bool profileViewRequestStatus;
  bool galleryViewRequestStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["user_id"],
    packageUpdateAlert: json["package_update_alert"],
    photo: json["photo"],
    name: json["name"],
    age: json["age"],
    religion: json["religion"],
    country: json["country"],
    membership: json["membership"],
    code: json["code"],
    height: json["height"],
    mothereTongue: json["mothere_tongue"],
    expressInterest: json["express_interest"],
    interestStatus: json["interest_status"],
    shortlistStatus: json["shortlist_status"],
    reportStatus: json["report_status"],
    profileViewRequestStatus: json["profile_view_resquest_status"],
    galleryViewRequestStatus: json["gallery_view_resquest_status"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "package_update_alert": packageUpdateAlert,
    "photo": photo,
    "name": name,
    "age": age,
    "religion": religion,
    "country": country,
    "membership": membership,
    "code": code,
    "height": height,
    "mothere_tongue": mothereTongue,
    "express_interest": expressInterest,
    "interest_status": interestStatus,
    "shortlist_status": shortlistStatus,
    "report_status": reportStatus,
    "profile_view_resquest_status": profileViewRequestStatus,
    "gallery_view_resquest_status": galleryViewRequestStatus,
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
