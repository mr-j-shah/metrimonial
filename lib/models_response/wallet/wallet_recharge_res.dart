// To parse this JSON data, do
//
//     final walletRechargeResponse = walletRechargeResponseFromJson(jsonString);

import 'dart:convert';

WalletRechargeResponse walletRechargeResponseFromJson(String str) =>
    WalletRechargeResponse.fromJson(json.decode(str));

String walletRechargeResponseToJson(WalletRechargeResponse data) =>
    json.encode(data.toJson());

class WalletRechargeResponse {
  WalletRechargeResponse({
    this.result,
    this.url,
    this.message,
  });

  bool result;
  String url;
  String message;

  factory WalletRechargeResponse.fromJson(Map<String, dynamic> json) =>
      WalletRechargeResponse(
        result: json["result"] == null ? null : json["result"],
        url: json["url"] == null ? null : json["url"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "url": url == null ? null : url,
        "message": message == null ? null : message,
      };

  WalletRechargeResponse.initialState()
      : result = false,
        url = '',
        message = '';
}
