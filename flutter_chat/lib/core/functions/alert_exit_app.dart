// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // void Function(bool)? alertExitApp;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void Function(bool)? alertExitApp;

// void showExitConfirmation(BuildContext context) {
//   Get.defaultDialog(
//     title: "تنبية",
//     middleText: "هل تريد الخروج من التطبيق",
//     actions: [
//       ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//           alertExitApp?.call(true); // Call the callback with true
//         },
//         child: const Text("Confirm"),
//       ),
//       ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//           alertExitApp?.call(false); // Call the callback with false
//         },
//         child: const Text("Cancel"),
//       ),
//     ],
//   );
// }


// // // Function to show an exit confirmation dialog
// // Future<bool?> alertExitApp(BuildContext context) {
// //   return Get.defaultDialog<bool?>(
// //     context: context,
// //     builder: (context) => AlertDialog(
// //       title: const Text("تنبية"),
// //       content: const Text("هل تريد الخروج من التطبيق"),
// //       actions: [
// //         TextButton(
// //           onPressed: () => Navigator.of(context).pop(true),
// //           child: const Text("تأكيد"),
// //         ),
// //         TextButton(
// //           onPressed: () => Navigator.of(context).pop(false),
// //           child: const Text("إلغاء"),
// //         ),
// //       ],
// //     ),
// //   );
// // }