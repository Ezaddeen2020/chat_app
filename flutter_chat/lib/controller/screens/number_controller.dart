// import 'package:chat_application/view/Screens/auth/verifying_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// abstract class NumberController extends GetxController {
//   void setCountry(String name, String code, String flag);
//   void dialogWithNum();
//   void dialogWithNoNum();
// }

// class NumberControllerImp extends NumberController {
//   var countryname = "Yemen".obs;
//   var countrycode = "+967".obs;
//   var countryflag = "🇾🇪".obs;
//   var mycontrol = TextEditingController();
//   // late TextEditingController mycontrol;

//   @override
//   void setCountry(name, code, flag) {
//     countryname.value = name;
//     countrycode.value = code;
//     countryflag.value = flag;
//     update();
//     Get.back();
//   }

//   @override
//   void dialogWithNum() {
//     Get.dialog(
//       AlertDialog(
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Text(
//                 "we will be verifying your phone number",
//                 style: TextStyle(fontSize: 14),
//               ),
//               Obx(() => Text(
//                     "${countrycode.value} ${mycontrol.text}",
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.w500),
//                   )),
//               const SizedBox(height: 10),
//               const Text(
//                 "Is this Ok, or would you like to edit the number?",
//                 style: TextStyle(fontSize: 13.5),
//               )
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//             },
//             child: const Text("Edit"),
//           ),
//           TextButton(
//             onPressed: () {
//               Get.back();
//               Get.to(() => 
//               // const Login()
//                OtpScreen(
//                     countrycode: countrycode.value,
//                     number: mycontrol.text,
//                   ),
//                   );
//               // Get.toNamed(AppRoute.verifyCode);
//             },
//             child: const Text("Ok"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dialogWithNoNum() {
//     Get.dialog(
//       AlertDialog(
//         content: const SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 10),
//               Text(
//                 "insert your number in a correct way",
//                 style: TextStyle(fontSize: 14),
//               )
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//             },
//             child: const Text("Ok"),
//           ),
//         ],
//       ),
//     );
//   }
// }
