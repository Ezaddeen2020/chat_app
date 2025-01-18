// import 'dart:async';

// import 'package:get/get.dart'; 
// import 'package:shared_preferences/shared_preferences.dart';

// // تم تعريف البريفرنس في هذا المكان من اجل - إدارة مركزية للبيانات للمستخدمين بحيث يتم الوصول اليها في اي وقت
// // عند بدء التطبيق فقط GetxService تحميل مرة واحدة بأستخدام SharedPreferences   

// class MyServices extends GetxService {
//   late SharedPreferences sharedPreferences;

 
// //  عند بدء التطبيق SharedPreferences وظيفة هذه الدالة تقوم بتهيئة 
// //  مرة ةاحدة عند بدء التطبيق SharedPreferences يتم تحميل 
// //  وبالتالي يكون جاهز للأستخدام في اي مكان في التطبيق SharedPreferences نفسه بعد تهيئة الـ MyServices هذه الدالة تعيد الكائن 
//   Future<MyServices> init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     return this;
//   }
  
// } 

// initialServices() async {
//   await Get.putAsync(() => MyServices().init()); 
// }
// //استخدام هاتين الدالتين معًا يُحقق تحميلًا غير متزامن لخدمة مركزية تستخدم 
// //SharedPreferences