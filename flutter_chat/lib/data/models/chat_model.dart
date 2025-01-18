// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:chatapp/data/models/messages_model.dart';

// Parse JSON string into a ChatModel object
ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

// Convert a ChatModel object into a JSON string
String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  final int msgId;
  final int senderId;
  final int receiverId;
  MessageModel? message;
  late final bool msgSent;
  bool msgView;
  final String msgType;
  final String msgKey;
  DateTime timestamp;

  ChatModel({
    required this.msgId,
    required this.senderId,
    required this.receiverId,
    this.message,
    this.msgSent = false,
    this.msgView = false,
    required this.msgType,
    required this.msgKey,
    required this.timestamp,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    // var date = DateTime.parse(json['msg_date']);
    var date = DateTime.parse(json['msg_date'] ?? DateTime.now().toString());

    return ChatModel(
      msgId: json['msg_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      receiverId: json['receiver_id'] ?? 0,
      message: json['message'] != null ? MessageModel.fromJson(json['message']) : null,
      msgSent: json['msg_sent'] == 1 ? true : false,
      msgView: json['msg_view'] == 1 ? true : false,
      msgType: json['msg_type'] ?? "",
      msgKey: json['msg_key'] ?? "",
      timestamp: json['msg_date'] != null
          ? DateTime.parse(date.toIso8601String()).isUtc
              ? date
              : DateTime.parse("${date.toIso8601String()}Z").toLocal()
          : DateTime.now().toLocal(),
    );
  }

  factory ChatModel.fromJsonlocal(Map<String, dynamic> json) => ChatModel(
        msgId: json['msgId'],
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        message: json['msg'] != null ? MessageModel.fromJson(json['msg']) : null,
        msgSent: json['msgSent'] == 1 ? true : false,
        msgView: json['msgView'] == 1 ? true : false,
        msgType: json['msgType'],
        msgKey: json['msgKey'],
        timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toString()),
      );
  //     ChatModel chat = ChatModel.fromJsonlocal(jsonData)
  // print("Timestamp: ${chat.timestamp}");

  get isGroub => null;

  //  ChatModel object into a JSON representation
  Map<String, dynamic> toJsonSocket() {
    return {
      'msg_id': msgId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message?.toJson(),
      'msg_sent': msgSent ? 1 : 0,
      'msg_view': msgView ? 1 : 0,
      'msg_type': msgType,
      'msg_key': msgKey,
      'msg_date': timestamp.toUtc().toIso8601String(),
    };
  }

  //  ChatModel object into a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'msgId': msgId,
      'senderId': senderId,
      'receiverId': receiverId,
      'msg': message?.toJson(),
      'msgSent': msgSent ? 1 : 0,
      'msgView': msgView ? 1 : 0,
      'msgType': msgType,
      'msgKey': msgKey,
      'timestamp': timestamp.toUtc().toIso8601String(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> data) {
    return ChatModel(
      msgId: data['msgId'] ?? 0,
      senderId: data['senderId'] ?? 0,
      receiverId: data['receiverId'] ?? 0,
      message: data['message'] != null ? MessageModel.fromJson(data['message']) : null,
      msgSent: data['msgSent'] == 1 ? true : false,
      msgView: data['msgView'] == 1 ? true : false,
      msgType: data['msgType'] ?? 'Text',
      msgKey: data['msgKey'] ?? '',
      timestamp: data['timestamp'] != null ? DateTime.parse(data['timestamp']) : DateTime.now(),
    );
  }

  ChatModel copyWith({
    int? msgId,
    int? senderId,
    int? receiverId,
    MessageModel? message,
    bool? msgSent,
    bool? msgView,
    String? msgType,
    String? msgKey,
    bool? isEdited,
    DateTime? timestamp,
  }) {
    return ChatModel(
      msgId: msgId ?? this.msgId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      msgSent: msgSent ?? this.msgSent,
      msgView: msgView ?? this.msgView,
      msgType: msgType ?? this.msgType,
      msgKey: msgKey ?? this.msgKey,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
