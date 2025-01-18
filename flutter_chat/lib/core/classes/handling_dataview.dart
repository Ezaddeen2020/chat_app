
// import 'package:chatapp/core/classes/status_request.dart';
// import 'package:chatapp/core/constant/imageassets.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class HandlingDataview extends StatelessWidget {
//   const HandlingDataview(
//       {super.key, required this.statusRequest, required this.widget});
//   final StatusRequest statusRequest;
//   final Widget widget;

//   @override
//   Widget build(BuildContext context) {
//     return statusRequest == StatusRequest.loading
//         ? Center(
//             child:
//                 Lottie.asset(AppImageAssets.loading, width: 250, height: 250))
//         : statusRequest == StatusRequest.offlinefailure
//             ? Center(
//                 child: Lottie.asset(AppImageAssets.offline,
//                     width: 250, height: 250))
//             : statusRequest == StatusRequest.serverfauiler
//                 ? Center(
//                     child: Lottie.asset(AppImageAssets.server,
//                         width: 250, height: 250))
//                 : statusRequest == StatusRequest.failure
//                     ? Center(
//                         child: Lottie.asset(AppImageAssets.nodata,
//                             width: 250, height: 250))
//                     : widget;
//   }
// }

// class HandlingDataRequest extends StatelessWidget {
//   const HandlingDataRequest(
//       {super.key, required this.statusRequest, required this.widget});
//   final StatusRequest statusRequest;
//   final Widget widget;

//   @override
//   Widget build(BuildContext context) {
//     return statusRequest == StatusRequest.loading
//         ? Center(
//             child:
//                 Lottie.asset(AppImageAssets.loading, width: 250, height: 250))
//         : statusRequest == StatusRequest.offlinefailure
//             ? Center(
//                 child: Lottie.asset(AppImageAssets.offline,
//                     width: 250, height: 250))
//             : statusRequest == StatusRequest.serverfauiler
//                 ? Center(
//                     child: Lottie.asset(AppImageAssets.server,
//                         width: 250, height: 250))
//                 : widget;
//   }
// }

//   // get: ^4.6.5
//   //  # DateTime
//   // jiffy: ^6.3.0
//   // intl: ^0.19.0
//   // http: ^1.2.0
//   // # Images
//   // cached_network_image: ^3.3.0
//   // image_picker: ^1.1.1
//   // # Animate
//   // show_up_animation: ^2.0.0
//   // auto_animated: ^3.1.0
//   // # Google Map
//   // flutter_polyline_points: ^2.0.0
//   // # google_maps_flutter: ^2.7.0
//   // geolocator: ^11.1.0
//   // geocoding: ^2.2.2
//   // # Firebase And Notification
//   // firebase_messaging: ^14.9.4
//   // firebase_core: ^2.32.0
//   // flutter_local_notifications: ^17.1.2
//   // cloud_firestore: ^4.17.5
//   // # # Local Data Cache
//   // sqflite: ^2.3.3
//   // shared_preferences: ^2.2.3
//   // path: ^1.9.0
//   // # # Qrcode
//   // qr_flutter: ^4.1.0
//   // scan: ^1.5.2
//   // grouped_list: ^5.1.2
//   // url_launcher: ^6.2.6
//   // dropdown_search: ^5.0.6
//   // badges: ^3.1.2
//   //  # Icon
//   // flutter_svg: ^2.0.10
//   // font_awesome_flutter: ^10.7.0
//   // fluttericon: ^2.0.0
//   // dartz: ^0.10.1
//   //  # # Google Auth
//   // google_sign_in: ^6.2.1
//   // device_preview: ^1.2.0
//   // responsive_builder: ^0.7.0
//   // flutter_otp_text_field: ^1.1.3+2
//   // lottie: ^3.1.2