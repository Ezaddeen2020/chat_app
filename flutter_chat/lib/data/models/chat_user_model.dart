// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chat_application/data/models/chat_model.dart';
import 'package:chat_application/data/models/user_model.dart';

class ChatUserModel {
  final UserModel user;
  List<ChatModel>? chatModellist; // we use this list for adding the new comming messages
  int countNotRead;
  final bool isBlock;
  late bool isOnline;
  ChatUserModel({
    required this.user,
    this.chatModellist,
    this.countNotRead = 0,
    this.isBlock = false,
    this.isOnline = false,
  });

  ChatUserModel copyWith({
    UserModel? user,
    ChatModel? chat,
    int? countNotRead,
    List<ChatModel>? chatUser,
    bool? isBlock,
    bool? isOnline,
  }) {
    return ChatUserModel(
      user: user ?? this.user,
      chatModellist: chatUser ?? List.from(chatModellist ?? []),
      countNotRead: countNotRead ?? this.countNotRead,
      isBlock: isBlock ?? this.isBlock,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'countNotRead': countNotRead,
      'isBlock': isBlock,
      'isOnline': isOnline,
      "user": user.toJson(),
      "listChat": chatModellist?.map((e) => e.toJson()).toList(),
    };
  }

//
  factory ChatUserModel.fromJson(Map<String, dynamic> map) {
    return ChatUserModel(
      chatModellist: [ChatModel.fromJson(map)],
      user: UserModel.fromJson(map),
      countNotRead: map['countNotRead'] ?? 0, // تأكد من تضمين هذا الحقل
      isBlock: map['isBlock'] == 1, // تحويل من int إلى bool
      isOnline: map['isOnline'] == 1, // تحويل من int إلى bool
    );
  }

  // factory ChatUserModel.fromJsonlocal(Map<String, dynamic> map) {
  //   return ChatUserModel(
  //     chatModellist: map['listChat'] != null
  //         ? List<ChatModel>.from(
  //             (map['listChat'] as List).map((e) => ChatModel.fromJsonlocal(e)),
  //           )
  //         : [],
  //     user: UserModel.fromJsonLocal(map['user']),
  //     chat: map['chat'] != null ? ChatModel.fromJsonlocal(map['chat']) : null,
  //   );
  // }
  factory ChatUserModel.fromJsonlocal(Map<String, dynamic> map) {
    return ChatUserModel(
      user: UserModel.fromJsonLocal(map['user']),
      chatModellist: map['listChat'] != null
          ? List<ChatModel>.from(
              (map['listChat'] as List).map((e) => ChatModel.fromJsonlocal(e)),
            )
          : [],
      countNotRead: map['countNotRead'] ?? 0, // Add this line
      isBlock: map['isBlock'] ?? false, // Add this line
      isOnline: map['isOnline'] ?? false, // Add this line
    );
  }
}
