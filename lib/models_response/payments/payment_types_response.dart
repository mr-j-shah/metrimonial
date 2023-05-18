// To parse this JSON data, do
//
//     final paymentTypesResponse = paymentTypesResponseFromJson(jsonString);

import 'dart:convert';

PaymentTypesResponse paymentTypesResponseFromJson(String str) =>
    PaymentTypesResponse.fromJson(json.decode(str));

String paymentTypesResponseToJson(PaymentTypesResponse data) =>
    json.encode(data.toJson());

class PaymentTypesResponse {
  PaymentTypesResponse({
    this.result,
    this.data,
  });

  bool result;
  List<Data> data;

  factory PaymentTypesResponse.fromJson(Map<String, dynamic> json) =>
      PaymentTypesResponse(
        result: json["result"] == null ? null : json["result"],
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  PaymentTypesResponse.initialState()
      : result = false,
        data = [];
}

class Data {
  Data({
    this.paymentType,
    this.paymentTypeKey,
    this.image,
    this.name,
    this.title,
    this.offlinePaymentId,
    this.details,
  });

  String paymentType;
  String paymentTypeKey;
  String image;
  String name;
  String title;
  int offlinePaymentId;
  String details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        paymentTypeKey:
            json["payment_type_key"] == null ? null : json["payment_type_key"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        title: json["title"] == null ? null : json["title"],
        offlinePaymentId: json["offline_payment_id"] == null
            ? null
            : json["offline_payment_id"],
        details: json["details"] == null ? null : json["details"],
      );

  Map<String, dynamic> toJson() => {
        "payment_type": paymentType == null ? null : paymentType,
        "payment_type_key": paymentTypeKey == null ? null : paymentTypeKey,
        "image": image == null ? null : image,
        "name": name == null ? null : name,
        "title": title == null ? null : title,
        "offline_payment_id":
            offlinePaymentId == null ? null : offlinePaymentId,
        "details": details == null ? null : details,
      };

  Data.initialState()
      : paymentType = '',
        paymentTypeKey = '',
        image = '',
        name = '',
        title = '',
        offlinePaymentId = 0,
        details = '';
}
