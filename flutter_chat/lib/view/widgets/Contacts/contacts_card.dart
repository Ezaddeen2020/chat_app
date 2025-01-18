// // contact_tile.dart

// import 'package:flutter/material.dart';
// import 'package:chatapp/data/models/chat_user_model.dart';
// import 'package:chatapp/controller/home_controller.dart';
// import 'package:get/get.dart';

// class ContactTile extends StatelessWidget {
//   final ChatUserModel userModel;
//   final String? trailingText;

//   ContactTile({super.key, required this.userModel, this.trailingText});

//   final HomeController homeController = Get.find<HomeController>();

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
//       leading: CircleAvatar(
//         radius: 24,
//         backgroundImage:
//             userModel.user.userImg != null && userModel.user.userImg.isNotEmpty
//                 ? AssetImage(userModel.user.userImg)
//                 : null,
//         child: userModel.user.userImg == null || userModel.user.userImg.isEmpty
//             ? const Icon(Icons.person, size: 24)
//             : null,
//       ),
//       title: Text(
//         userModel.user.userName,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       subtitle: Text(
//         userModel.user.userStatus?.isNotEmpty == true
//             ? userModel.user.userStatus!
//             : "",
//         style: const TextStyle(color: Colors.grey, fontSize: 14),
//       ),
//       trailing: trailingText != null
//           ? Text(
//               trailingText!,
//               style: const TextStyle(
//                   color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold),
//             )
//           : null,
//       onTap: () {
//         homeController.goToIndiviual(userModel);
//       },
//     );
//   }
// }
