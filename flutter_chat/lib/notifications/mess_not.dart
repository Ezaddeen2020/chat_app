// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart';


// //Service Account باستخدام حساب الخدمة Access Token from Google API الحصول على رمز الوصول
// var serviceAcount = {
//   "type": "service_account",
//   "project_id": "chatapp-83e16",
//   "private_key_id": "25e0c220f13e23ec8283c240f7520c49b665300e",
//   "private_key":
//       "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDEV6YKfSF4ANsX\nl9sEmU3PNl9RmK4op97yaP0h3ucfyAV+PqVUBDORd5w8jp9NU5pK4+vpqsZHJJC4\n5nOCF5Zom72TyW+/StygicjDZoJca/hR3GJtVUP67YcUl6PCBw9vK6QupOrnZ3h/\nveV/DeOjM+Xal/I2wAN99nk5JjomqFvkDYEEhCOMcyTyKQcWvJoTxnhtDfAAZURc\nMcGpofpk4jftVNY7FuasbugZzbzcqOwTiakMi9z+fS4Ab0SB3go/oKapBy61G0YI\nqbsHShZ7F8xdnS7mJBn8NvTh5ugDp1/bJtXHQLeCZ7QgHeF+9Mg77iMaA422JTkn\nHbRVF7dxAgMBAAECggEAPeu4gVFSR1LZxdiN6abhi6qFqCmjL041+TRUNKTkNjky\nRkzCfjsu+j8DJnQCWHQ30kuMQK6rho9JFw8SuaHvvQD06lFabTVSXEzn5HwFO9mP\nQF3lKr77x/y2H6/tJMluPCzCxDUdoioXLg44/Pdn5bX91REbgdnPoB+lvnjIWR0s\n4+WNCTKOqggrgpBBJ2iVGKNjup14R5W/h6Rli5OJoaiePGfAibPdl2mqLFU7n0D7\niRDuujndtMIONSOqgObtkH3JOxixuH+4LZESA6J/cqAJTxniaGENl73JDV1h8Gh9\nTeMIBCyd89abJG2wdLDkTvYunVxFom34J/h+tcpZ6wKBgQDuaG0rzflE9PekHAB8\nR3oMHiwpbnN91v1A7/23uEzRwqPCgGM/ZPGh2XnZo9cucyIsFZfd3PAWxM3+G9Ot\nBiduwR+RZ+GO0FXw36DIS3SPO2cPq2NYvmH4x7LB2bkHGssPdPA3smJiMyJ1cZ6u\nuCtYQ3IQp4yyQonO3dBn5kojywKBgQDS1Jh8txIgVeNj6yY8WTZZGwiO2CRu9ymD\nH6ih0fU4bGlNnEh732yEAf1qfSErvtoqhGODGPWkSteFw0D8g9bhKQMA0ayF0y1h\nCPCT5dW5uF+g0d6oK0UuG5KQP0KzrB7chHSvWFVXsDVyXjNV5gOL2nR1vSv9eTK1\nhpxbLMECMwKBgQDhaBRIBU93lhEJtXv0BPRsvp5MceR6BymdGwsMiBEBhgCk5hRw\nHLWkq+TcFF9fyHV3rtbOapUJQfvtFEw3XAkuWyPIq6oECBApVJZEqarDvYs8snOU\ntTQWLmFhjMO25us0awCv+FWyuNwMpGc+lFxO8D3JZ1DMPcLjtq7TfVV9rwKBgAsU\nSP8kz7sLSGvTy6qYNZbxKL349dEvA+t0GnSGiBBzAgWmFNkNoLI/OIYEFV4rJWPe\nmSwmf6ImnLTW0e9zLjOe6B1+50YRFu1mft4G0fh0i/HzlXPY8kW+BTG3YVX30Zdd\nDpS4W6PECsr70E7PS5hp3nzheBJV8ChB7q2L6IipAoGAdqcvUdikPPpThyn+XNP7\nht49f0nIy15mzpwMm4rb/smLg8nbE7qN9KVWDyoOa3O6vmhhqJiiCMbqozFbP4jz\naUI9YX1t4ts2or9YX1XZQZ7UVUmBsyqHRgUiYTDtjTiyxjaH7l+Lj153kjmRM5MH\n9/3dKuwbw0SDCbsVT7jQs4A=\n-----END PRIVATE KEY-----\n",
//   "client_email": "chat-key@chatapp-83e16.iam.gserviceaccount.com",
//   "client_id": "113740873472201127670",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url":
//       "https://www.googleapis.com/robot/v1/metadata/x509/chat-key%40chatapp-83e16.iam.gserviceaccount.com",
//   "universe_domain": "googleapis.com"
// };


// // Get the access token 
// //لإرسال الإشعارات Firebase API تُستخدم على السيرفر للحصول على رموز الوصول التي تسمح بالتفاعل مع
// Future<String> _getAccessToken() async {
//   try {
//     final client = await clientViaServiceAccount( 
//         ServiceAccountCredentials.fromJson(serviceAcount),
//         ['https://www.googleapis.com/auth/firebase.messaging'] // FCM والتي تتيح للتطبيق إرسال إشعارات عبر API تحديد النطاقات المطلوبة للوصول الى 
//         );

//     final accessToken = client.credentials.accessToken.data;
//     return accessToken;
//   } catch (_) {
//     // Handle errors in obtaining the access token
//     throw Exception('Error getting access token');
//   }
// }



// //using POST Request دالة إرسال الإشعارات
// Future<bool> sendNotification({ 
//   required String projectId,
//   required String recipientFCMToken,
//   required Map<String, dynamic> data,
// }) async {
//   final String accessToken = await _getAccessToken();
//   log(' =====Access Token ======= ${accessToken}');

// //Bearer Token الذي حصلنا علية بواسطة Access Token  من اجل المصادقة على headers اعداد  
// // كأنّه "تذكرة دخول" إلى النظام. بدون هذه التذكرة، لن يُسمح لك بالوصول إلى الموارد المحمية:Bearer Token
//   String fcmEndpoint = "https://fcm.googleapis.com/v1/projects/$projectId";
//   //لكي يقوم بإرسال إشعار. FCM إلى POST  هو الرابط الذي يرسل طلب 
//   final url = Uri.parse('$fcmEndpoint/messages:send');// API تحديد وظيفة إرسال الرسائل في
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     'Authorization': 'Bearer $accessToken',
//   };

//   // Convert the [model] to a Json for the request body

//   final reqBody = jsonEncode(
//     {
//       "message": {
//         "token": recipientFCMToken,
//         "data": data,
//         "notification": {"body": data['body'], "title": data['title']},
//         "android": {
//           "notification": {
//             "click_action": "FLUTTER_NOTIFICATION_CLICK",
//             "tag": "fmc-889564144",
//           }
//         },
//         "apns": {
//           "payload": {
//             "aps": {"category": "NEW_NOTIFICATION"}
//           }
//         }
//       }
//     },
//   );

//   try {
//     final response = await http.post(url, headers: headers, body: reqBody);
//     // print(response.body);
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   } catch (_) {
//     // Handle errors in sending the notification
//     return false;
//   }
// }
