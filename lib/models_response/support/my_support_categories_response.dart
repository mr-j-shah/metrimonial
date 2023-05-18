// To parse this JSON data, do
//
//     final myTicketCategoriesResponse = myTicketCategoriesResponseFromJson(jsonString);

import 'dart:convert';

MyTicketCategoriesResponse myTicketCategoriesResponseFromJson(String str) =>
    MyTicketCategoriesResponse.fromJson(json.decode(str));

String myTicketCategoriesResponseToJson(MyTicketCategoriesResponse data) =>
    json.encode(data.toJson());

class MyTicketCategoriesResponse {
  MyTicketCategoriesResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<Data> data;
  Links links;
  Meta meta;

  factory MyTicketCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      MyTicketCategoriesResponse(
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links == null ? null : links.toJson(),
        "meta": meta == null ? null : meta.toJson(),
      };

  MyTicketCategoriesResponse.initialState()
      : data = [],
        links = Links.initialState(),
        meta = Meta.initialState();
}

class Data {
  Data({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
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
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };

  Data.initialState()
      : id = 0,
        name = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        deletedAt = DateTime.now();
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
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
        "prev": prev,
        "next": next,
      };

  Links.initialState()
      : first = '',
        last = '',
        prev = '',
        next = '';
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
        currentPage: json["current_page"] == null ? null : json["current_page"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "links": links == null
            ? null
            : List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };

  Meta.initialState()
      : currentPage = 0,
        from = 0,
        lastPage = 0,
        links = [],
        path = '',
        perPage = 0,
        to = 0,
        total = 0;
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
        url: json["url"] == null ? null : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
      };

  Link.initialState()
      : url = '',
        label = '',
        active = false;
}
