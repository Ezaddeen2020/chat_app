// ignore_for_file: file_names

import 'dart:convert';

import 'package:chat_application/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const isLogin = "isLogin";
  static const email = "email";
  static const users = "user";

  // static const userId = "userID";
  // static const password = "password";
  // static const token = "token";
  // static const isAdmin = "isAdmin";
  // static const isAccountAdmin = "account";
  // static const showSplash = "showSplash";
  //contact
  // static const contact = "contact";
  // static const setting = "setting";

  static late SharedPreferences pref;

  static initPref() async {
    pref = await SharedPreferences.getInstance();
  }

// is the user logged in or not
  static bool getBoolean(String key) {
    return pref.getBool(key) ?? false;
  }

  static Future<void> setBoolean(String key, bool value) async {
    await pref.setBool(key, value);
  }

//Storage and retrieval of user data
  static String getString(String key) {
    return pref.getString(key) ?? "";
  }

  static Future<void> setString(String key, String value) async {
    await pref.setString(key, value);
  }

  static Future<void> setListString(String key, List<String>? value) async {
    await pref.setStringList(key, value ?? []);
  }

  static List<String> getListString(String key) {
    return pref.getStringList(key) ?? [];
  }

  static int getInt(String key) {
    return pref.getInt(key) ?? 0;
  }

  static Future<void> setInt(String key, int value) async {
    await pref.setInt(key, value);
  }

//===========================
  static Future<void> clearSharPreference() async {
    await pref.clear();
  }

//===========================
  static Future<void> setDataUser(UserModel userModel) async {
    var mapEncode = jsonEncode(userModel.toJson());
    //key and value JSON store on the pref
    await pref.setString(users, mapEncode);
  }

//===========================
//عند استعادة بيانات المستخدم يجب اولا ان نقوم بإنشاء دالة من نوع  مودل لأسترجاع بيانات المستخدمين
//ثم نقوم بإنشاء متغير لقراءة البيانات في البرفرينس بواسطة المفتاح يوزر

  static UserModel? getDataUser() {
    var mapDecode = pref.getString(users);

    if (mapDecode == null || mapDecode.trim().isEmpty) {
      return null;
    }
    try {
      var userDecode = json.decode(mapDecode);
      var userModel = UserModel.fromJsonLocal(userDecode);
      return userModel;
    } catch (e) {
      print("Error decoding user data: $e");
      return null;
    }
  }
}
