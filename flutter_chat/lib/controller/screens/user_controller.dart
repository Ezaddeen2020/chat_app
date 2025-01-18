import 'package:chatapp/data/models/preferences.dart';
import 'package:chatapp/data/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserModel? userModel;

  //اذا تم العثور على البيانات يتم استدعاء دالة جلب البيانات في صفحة هوم بيج كنترولر  SharedPreferences دالة التحقق من وجود بيانات للمستخدم في
  //اذا لم يتم العثور على بيانات يتم توجية المستخدم الى صفحة تسجيل الدخول

  Future<void> getPreferenceUser() async {
    userModel = Preferences.getDataUser();
    update();
  }

//
  void setPreferenceUser(UserModel user) {
    Preferences.setBoolean(Preferences.isLogin, true); // تعيين حالة تسجيل الدخول
    Preferences.setDataUser(user);
    userModel = user; // تحديث الكائن userModel
    update();
  }

  Future<void> logout() async {
    await Preferences.clearSharPreference(); // حذف البيانات
    userModel = null; // إعادة تعيين المستخدم
    Get.offAllNamed('/'); // إعادة التوجيه إلى شاشة تسجيل الدخول
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getPreferenceUser(); // تحميل بيانات المستخدم عند التهيئة
  }
}
