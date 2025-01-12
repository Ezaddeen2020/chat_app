import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.userImage, this.userName});
  final String? userImage;
  final String? userName;
  @override
  Widget build(BuildContext context) {
    final String? userImage = Get.arguments?['user_img'];
    // final String? userName = Get.arguments?['user_'];
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: userImage != null
                ? FileImage(File(userImage))
                : const AssetImage("assets/images/photo.JPG") as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent[700],
              radius: 10,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      title: const Text(
        // userName != null ? userName: const Text("my status"),
        "My Status",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "Tab to add status update",
        style: TextStyle(color: Colors.grey[900], fontSize: 12),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:chat_application/controller/screens/user_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final UserController userController = Get.find<UserController>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: Obx(() {
//         // التأكد من أن userModel قيمة صحيحة
//         if (userController.userModel.value.userId == 0) {
//           return const Center(child: Text('No user data available'));
//         }

//         final user = userController.userModel.value;

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: user.userImg != null
//                     ? FileImage(File(user.userImg!))
//                     : const AssetImage("assets/images/photo.JPG") as ImageProvider,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 user.userName,
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 user.userEmail,
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 user.userPhone,
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   userController.logout();  // زر تسجيل الخروج
//                 },
//                 child: const Text('Logout'),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
