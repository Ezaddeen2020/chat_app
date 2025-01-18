import 'package:camera/camera.dart';
import 'package:chatapp/core/constant/colors.dart';
import 'package:chatapp/core/localization/change_local.dart';
import 'package:chatapp/core/localization/translations.dart';
import 'package:chatapp/data/models/preferences.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/notifications/notifi_class.dart';
import 'package:chatapp/routes_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Preferences.initPref();
  // await initialServices();
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
      builder: EasyLoading.init(),
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
      // initialBinding: InitialBindings(),
      getPages: routesScreens,
    );
  }
}
