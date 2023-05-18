// To parse this JSON data, do
//
//     final chatDetailsResponse = chatDetailsResponseFromJson(jsonString);

import 'dart:convert';

ChatDetailsResponse chatDetailsResponseFromJson(String str) =>
    ChatDetailsResponse.fromJson(json.decode(str));

String chatDetailsResponseToJson(ChatDetailsResponse data) =>
    json.encode(data.toJson());

class ChatDetailsResponse {
  ChatDetailsResponse({
    this.data,
    this.result,
  });

  Data data;
  bool result;

  factory ChatDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ChatDetailsResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "result": result == null ? null : result,
      };

}

class Data {
  Data({
    this.receiverName,
    this.receiverPhoto,
    this.senderName,
    this.authUserPhoto,
    this.messages,
  });

  String receiverName;
  String receiverPhoto;
  String senderName;
  String authUserPhoto;
  List<Message> messages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        receiverName:
            json["receiver_name"] == null ? null : json["receiver_name"],
        receiverPhoto:
            json["receiver_photo"] == null ? null : json["receiver_photo"],
        senderName: json["sender_name"] == null ? null : json["sender_name"],
        authUserPhoto:
            json["auth_user_photo"] == null ? null : json["auth_user_photo"],
        messages: json["messages"] == null
            ? null
            : List<Message>.from(
                json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "receiver_name": receiverName == null ? null : receiverName,
        "receiver_photo": receiverPhoto == null ? null : receiverPhoto,
        "sender_name": senderName == null ? null : senderName,
        "auth_user_photo": authUserPhoto == null ? null : authUserPhoto,
        "messages": messages == null
            ? null
            : List<dynamic>.from(messages.map((x) => x.toJson())),
      };

}

class Message {
  Message({
    this.id,
    this.chatThreadId,
    this.senderUserId,
    this.message,
    this.attachment,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int chatThreadId;
  int senderUserId;
  String message;
  dynamic attachment;
  int seen;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        chatThreadId:
            json["chat_thread_id"] == null ? null : json["chat_thread_id"],
        senderUserId:
            json["sender_user_id"] == null ? null : json["sender_user_id"],
        message: json["message"] == null ? null : json["message"],
        attachment: json["attachment"],
        seen: json["seen"] == null ? null : json["seen"],
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
        "chat_thread_id": chatThreadId == null ? null : chatThreadId,
        "sender_user_id": senderUserId == null ? null : senderUserId,
        "message": message == null ? null : message,
        "attachment": attachment,
        "seen": seen == null ? null : seen,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };

}
