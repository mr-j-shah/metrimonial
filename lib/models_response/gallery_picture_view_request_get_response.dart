// To parse this JSON data, do
//
//     final galleryPictureViewRequestGetResponse = galleryPictureViewRequestGetResponseFromJson(jsonString);

import 'dart:convert';

GalleryPictureViewRequestGetResponse
    galleryPictureViewRequestGetResponseFromJson(String str) =>
        GalleryPictureViewRequestGetResponse.fromJson(json.decode(str));

String galleryPictureViewRequestGetResponseToJson(
        GalleryPictureViewRequestGetResponse data) =>
    json.encode(data.toJson());

class GalleryPictureViewRequestGetResponse {
  GalleryPictureViewRequestGetResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<Data> data;
  Links links;
  Meta meta;

  factory GalleryPictureViewRequestGetResponse.fromJson(
          Map<String, dynamic> json) =>
      GalleryPictureViewRequestGetResponse(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };


}

class Data {
  Data({
    this.id,
    this.photo,
    this.name,
    this.dateOfBirth,
    this.status,
  });

  int id;
  String photo;
  String name;
  int dateOfBirth;
  int status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        photo: json["photo"],
        name: json["name"],
        dateOfBirth: json["date_of_birth"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "name": name,
        "date_of_birth": dateOfBirth,
        "status": status,
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
