import 'package:camera/camera.dart';
import 'package:chat_application/bindings/initial_bindings.dart';
import 'package:chat_application/core/constant/colors.dart';
import 'package:chat_application/core/localization/change_local.dart';
import 'package:chat_application/core/localization/translations.dart';
import 'package:chat_application/core/services/services.dart';
import 'package:chat_application/data/models/preferences.dart';
import 'package:chat_application/firebase_options.dart';
import 'package:chat_application/notifications/notifi_class.dart';
import 'package:chat_application/routes_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Preferences.initPref();
  await initialServices();
  cameras = await availableCameras();
  await _requestContactsPermission();
  await notificationService.init();
  notificationService.getToken();
  notificationService.initializeNotifications();

  FirebaseMessaging.onBackgroundMessage(handeleBachgroundMessage);

  runApp(const MyApp());
}

// وظيفة طلب إذن الوصول إلى جهات الاتصال
Future<void> _requestContactsPermission() async {
  var status = await Permission.contacts.status;
  if (!status.isGranted) {
    await Permission.contacts.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      locale: controller.language,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // scaffoldBackgroundColor: AppColors.blue,
        // scaffoldBackgroundColor: Colors.blueGrey[50],

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          displayMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          bodyLarge: TextStyle(
              color: AppColors.grey, fontWeight: FontWeight.bold, height: 2, fontSize: 14),
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      // home: const MyLanguage(),
      initialBinding: InitialBindings(),
      getPages: routesScreens,
    );
  }
}


// import 'package:camera/camera.dart';
// import 'package:chat_application/bindings/initial_bindings.dart';
// import 'package:chat_application/core/constant/colors.dart';
// import 'package:chat_application/core/localization/change_local.dart';
// import 'package:chat_application/core/localization/translations.dart';
// import 'package:chat_application/core/services/services.dart';
// import 'package:chat_application/data/models/preferences.dart';
// import 'package:chat_application/firebase_options.dart';
// import 'package:chat_application/notifications/notifi_class.dart';
// import 'package:chat_application/routes_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// late List<CameraDescription> cameras;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Preferences.initPref();
//   await initialServices();
//   cameras = await availableCameras();
//   await _requestContactsPermission();
//   await notificationService.init();
//   notificationService.getToken();
  
//   // تأكيد تسجيل الخلفية
//   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  
//   runApp(const MyApp());
// }

// // طلب إذن الوصول إلى جهات الاتصال
// Future<void> _requestContactsPermission() async {
//   var status = await Permission.contacts.status;
//   if (!status.isGranted) {
//     await Permission.contacts.request();
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     LocaleController controller = Get.put(LocaleController());
//     return GetMaterialApp(
//       translations: MyTranslation(),
//       locale: controller.language,
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         textTheme: const TextTheme(
//           displayLarge: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: AppColors.black,
//           ),
//           displayMedium: TextStyle(
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             color: AppColors.black,
//           ),
//           bodyLarge: TextStyle(
//             color: AppColors.grey,
//             fontWeight: FontWeight.bold,
//             height: 2,
//             fontSize: 14,
//           ),
//         ),
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: "/",
//       initialBinding: InitialBindings(),
//       getPages: routesScreens,
//     );
//   }
// }
