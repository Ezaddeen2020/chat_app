import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int userId;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userPhone;
  String? token;
  final dynamic user;
  final String? userStatus;
  final dynamic userImg;
  final bool isBlock; // غير nullable مع قيمة افتراضية

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhone,
    this.token,
    this.user,
    this.userStatus,
    this.userImg,
    this.isBlock = false, // تعيين القيمة الافتراضية لـ isBlock
  });

  UserModel copyWith({
    int? userId,
    String? userName,
    String? userEmail,
    String? userPassword,
    String? userPhone,
    String? token,
    dynamic user,
    dynamic userStatus,
    dynamic userImg,
    bool? isBlock,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
        userPhone: userPhone ?? this.userPhone,
        token: token ?? this.token,
        user: user ?? this.user,
        userStatus: userStatus ?? this.userStatus,
        userImg: userImg ?? this.userImg,
        isBlock: isBlock ?? this.isBlock,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"] ?? 0, // تعيين قيمة افتراضية
        userName: json["user_name"] ?? "", // تعيين قيمة افتراضية
        userEmail: json["user_email"] ?? "", // تعيين قيمة افتراضية
        userPassword: json["user_password"] ?? "", // تعيين قيمة افتراضية
        userPhone: json["user_phone"] ?? "", // تعيين قيمة افتراضية
        token: json["token"],
        user: json["user"],
        userStatus: json["user_status"],
        userImg: json["user_img"],
        isBlock: json["isBlock"] == 1,
      );

  factory UserModel.fromJsonLocal(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        userName: json["user"],
        userEmail: json["email"],
        userPassword: json["password"],
        userPhone: json["phone"],
        token: json["token"],
        user: json["user1"] ?? "",
        userStatus: json["user_status"] ?? "",
        userImg: json["user_img"] ?? "",
        // isBlock: json["isBlock"] == 1,
        isBlock: json["isBlock"] != null
            ? json["isBlock"] == 1
            : false, // تعيين القيمة الافتراضية إذا كانت null
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user": userName,
        "email": userEmail,
        "password": userPassword,
        "phone": userPhone,
        "token": token,
        "user1": user,
        "user_status": userStatus,
        "user_img": userImg,
        "isBlock": isBlock ? 1 : 0, // تحويل bool إلى int
      };

  factory UserModel.passWith({
    int? userId,
    String? userName,
    String? userEmail,
    String? userPassword,
    String? userPhone,
    String? token,
    dynamic user,
    dynamic userStatus,
    dynamic userImg,
    bool? isBlock,
  }) =>
      UserModel(
        userId: userId ?? 0,
        userName: userName ?? '',
        userEmail: userEmail ?? '',
        userPassword: userPassword ?? '',
        userPhone: userPhone ?? '',
        token: token ?? '',
        user: user ?? '',
        userStatus: userStatus ?? '',
        userImg: userImg ?? '',
        isBlock: isBlock ?? false,
      );
}
