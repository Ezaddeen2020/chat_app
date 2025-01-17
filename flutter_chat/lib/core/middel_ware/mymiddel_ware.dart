import 'package:chatapp/core/constant/routes.dart';
import 'package:chatapp/data/models/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//وسيط اثناء التنقل بين الصفحاتGetMiddleware
//تنفذ بعض الاجراءات قبل او بعد التوجية مثل التحقق من تسجيل الدخول

class MymiddelWare extends GetMiddleware {
  @override
  int? get priority => 1; //تحدد أولوية الوسيط
  // MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    // log(Preferences.getBoolean(Preferences.isLogin).toString());
    // log((Preferences.getDataUser() != null).toString());
    //هذه الدالة تُستخدم لإعادة توجيه المستخدم إلى صفحة محددة بناءً على بعض الشروط.
    if (Preferences.getString(Preferences.language).isEmpty) {
      return const RouteSettings(name: AppRoute.lang);
    }
    if (!Preferences.getBoolean(
            Preferences.isLogin) && // التحقق من حالة تسجيل الدخول ووجود بيانات المستخدم
        Preferences.getDataUser() == null) {
      return const RouteSettings(name: AppRoute.login);
    }
    return null;
  }
}
