// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:async';
import 'dart:developer';
import 'package:chat_application/socket/socket_class.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

NotificationService notificationService = NotificationService();

SocketClass socketClass = SocketClass();

//FCM الكلاس يحتوي على طرق لتهيئة الإشعارات (مثل التقديم في الواجهة الأمامية)، والاستماع للأحداث المتعلقة بالإشعارات، والحصول على التوكن الخاص ب
class NotificationService {
  // 1. خاصية ثابتة تحتوي على الكائن الوحيد.
  static final NotificationService _notificationService = NotificationService._internal();

  // 2. المنشئ الخاص الذي لا يسمح بإنشاء كائنات جديدة من الخارج.
  NotificationService._internal();

  // 3. دالة factory التي ترجع الكائن الوحيد.
  factory NotificationService() {
    return _notificationService;
  }

//
  Future<void> init() async {
    //تحديد كيفية عرض الاشعارات عندما يكون التطبيق مفتوح
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(hendleMessage); //routing on clicking to pages in App if it onBackground or terminated
    FirebaseMessaging.onMessageOpenedApp.listen(
        hendleMessage); //listening on clicking to pages out App and app is terminate هذه الدالة تُستخدم للاستماع عندما يفتح المستخدم التطبيق من إشعار وهو في الخلفية أو عند إغلاقه.
    FirebaseMessaging.onMessage.listen((event) {
      print("Received notification in foreground: ${event.notification?.title}");

      // عرض الإشعار باستخدام flutter_local_notifications
      if (event.notification != null) {
        showNotification(
          event.notification!.title,
          event.notification!.body,
        );
      }
    });

    socketClass.socketConnect();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'default_channel', // معرف القناة
      'Default Channel', // اسم القناة
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // معرف الإشعار
      title ?? 'Notification',
      body ?? 'You have received a notification.',
      platformChannelSpecifics,
    );
  }

  void hendleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  //================================ Permission & FCM Token(use to send the notification)
  Future<String> getToken() async {
    //تُستخدم في التطبيق للحصول على الرمز الذي يتيح استقبال الإشعارات.
    try {
      await FirebaseMessaging.instance.requestPermission(
        //اذن سماح للمستخدم في تمكين الاشعارات
        alert: true,
        announcement: false,
        badge: true, //number of notification which is not reading
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      final fCMToken = await FirebaseMessaging.instance.getToken();
      log(' =========== Token ============$fCMToken');

      return fCMToken ?? "";
    } catch (e) {
      return "";
    }
  }
}

Future<void> handeleBachgroundMessage(RemoteMessage message) async {
  var payloadData = message.toMap();
  print('===========on Background notification ===========');
  log(payloadData.toString());
  print('===========on Background notification ===========');
}

// import 'dart:async';
// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// NotificationService notificationService = NotificationService();

// class NotificationService {
//   static final NotificationService _notificationService = NotificationService._internal();
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   Future<void> init() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     // تهيئة الإشعارات المحلية
//     var androidInit = AndroidInitializationSettings('app_icon');
//     var initializationSettings = InitializationSettings(android: androidInit);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     // تفعيل الإشعارات في الواجهة الأمامية
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);

//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);  // عند الفتح من إشعار
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);  // عند فتح التطبيق من الخلفية

//     FirebaseMessaging.onMessage.listen((event) {
//       log('Received a message: ${event.notification?.title}');
//       handleForegroundNotification(event);  // عرض الإشعار عند الوصول في الواجهة الأمامية
//     });
//   }

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     log("Navigating to page from notification: ${message.data}");
//     // منطق للتوجيه إلى الصفحات بناءً على البيانات
//   }

//   Future<String> getToken() async {
//     try {
//       await FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//       await FirebaseMessaging.instance.setAutoInitEnabled(true);
//       final fCMToken = await FirebaseMessaging.instance.getToken();
//       log('FCM Token: $fCMToken');
//       return fCMToken ?? "";
//     } catch (e) {
//       log('Error getting token: $e');
//       return "";
//     }
//   }
// }

// // معالجة الإشعارات في الخلفية
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   var payloadData = message.toMap();
//   log('Received background message: $payloadData');
//   showLocalNotification(message.notification!);
// }

// // معالجة الإشعارات في الواجهة الأمامية
// void handleForegroundNotification(RemoteMessage message) {
//   if (message.notification != null) {
//     showLocalNotification(message.notification!);
//   }
// }

// // عرض الإشعار المحلي
// void showLocalNotification(RemoteNotification notification) {
//   var androidDetails = AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     channelDescription: 'channel_description',
//     importance: Importance.high,
//     priority: Priority.high,
//   );

//   var notificationDetails = NotificationDetails(android: androidDetails);

//   notificationService.flutterLocalNotificationsPlugin.show(
//     0,
//     notification.title,
//     notification.body,
//     notificationDetails,
//   );
// }

