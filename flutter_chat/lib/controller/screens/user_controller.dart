import 'package:chat_application/controller/home_controller.dart';
import 'package:chat_application/data/models/preferences.dart';
import 'package:chat_application/data/models/user_model.dart';
import 'package:chat_application/view/Screens/auth/login_screen.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserModel? userModel;

  //اذا تم العثور على البيانات يتم استدعاء دالة جلب البيانات في صفحة هوم بيج كنترولر  SharedPreferences دالة التحقق من وجود بيانات للمستخدم في
  //اذا لم يتم العثور على بيانات يتم توجية المستخدم الى صفحة تسجيل الدخول

  Future<void> getPreferenceUser() async {
    await Preferences.initPref(); // تهيئة SharedPreferences
    userModel = Preferences.getDataUser();

    if (userModel != null) {
      final homeController = Get.find<HomeController>();
      homeController.fetchData();
    } else {
      Get.offAll(() => const LoginScreen()); // التوجيه إلى شاشة تسجيل الدخول
    }

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
    Get.offAll(() => const LoginScreen()); // إعادة التوجيه إلى شاشة تسجيل الدخول
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getPreferenceUser(); // تحميل بيانات المستخدم عند التهيئة
  }
}

// class UserController extends GetxController {
//   UserModel? userModel;

//   // void getPrefernceUser() {                 // userModel وتخزينها في كائنSharedPreferences دالة الحصول على بيانات المستخدم من
//   //   userModel = Preferences.getDataUser();
//   //     print("Retrieved UserModel: $userModel"); // سجل التصحيح
//   //   update();
//   //   print('User loaded: ${userModel?.userEmail}'); // تحقق من تحميل الإيميل
//   // }
// // void getPrefernceUser() {
// //   userModel = Preferences.getDataUser();
// //   print("Retrieved UserModel: $userModel");

// //   if (userModel != null) {
// //     final homeController = Get.find<HomeController>();
// //     homeController.fetchData();
// //   }
// //   update();
// // }
// // Future<void> getPrefernceUser() async {
// //       await Preferences.initPref();  // Ensure SharedPreferences is initialized
// //       userModel =  Preferences.getDataUser(); // تأكد من انتظار البيانات

// //      print("Retrieved UserModel: $userModel");

// //     if (userModel != null) {
// //       final homeController = Get.find<HomeController>();
// //       homeController.fetchData(); // تحميل البيانات عند وجود مستخدم
// //     } else {
// //       Get.offAll(() => const LoginScreen()); // إعادة التوجيه إلى تسجيل الدخول إذا لم يوجد مستخدم
// //     }

// //     update();
// // }

// Future<void> getPrefernceUser() async {
//   await Preferences.initPref();  // تأكد من تهيئة SharedPreferences

//   userModel = Preferences.getDataUser();
//   print("Retrieved UserModel: $userModel");

//   if (userModel != null) {
//     final homeController = Get.find<HomeController>();
//     homeController.fetchData();
//   } else {
//     print("No user data found. Redirecting to LoginScreen.");
//     Get.offAll(() => const LoginScreen());  // التوجيه إلى شاشة تسجيل الدخول
//   }

//   update();
// }

//   void setPrefernceUser(UserModel user) {//SharedPreferences دالة تخزين بيانات المستخدم في
//     Preferences.setBoolean(Preferences.isLogin, true);  // تعيين حالة تسجيل الدخول
//     Preferences.setDataUser(user);
//     userModel = user;                   //بالبيانات الجديدة userModel تحديث الكائن
//     update();
//   }

//   @override
//   void onInit() async {
//     super.onInit();
//       await Preferences.initPref();  // تهيئة SharedPreferences
//     getPrefernceUser(); // تحميل بيانات المستخدم عند التهيئة
//   }
// }
