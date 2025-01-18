







// import 'package:chatapp/controller/home_controller.dart';
// import 'package:chatapp/core/constant/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:chatapp/controller/auth/featch_users_controller.dart';
// import 'package:chatapp/core/classes/status_request.dart';
// import 'package:chatapp/data/models/chat_user_model.dart';

// class SelectContacts extends StatelessWidget {
//   SelectContacts({super.key});

//   final ContactsController controller =
//       Get.put(ContactsController(), permanent: true);
//   final HomeController homeController = Get.find<HomeController>();

//   // إضافة حالة للتحكم في ظهور ListTile أو TextField
//   final RxBool isSearchVisible = false.obs;

//   Widget buildContactTile(ChatUserModel userModel, {String? trailingText}) {
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
//               trailingText,
//               style: const TextStyle(
//                   color: Colors.green,
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold),
//             )
//           : null,
//       onTap: () {
//         homeController.goToIndiviual(userModel);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // إظهار الـ ListTile فقط إذا كانت isSearchVisible = false
//               if (!isSearchVisible.value)
//                 Expanded(
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.only(left: 3),
//                     title: const Text(
//                       "Select Contacts",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     subtitle: Text(
//                       "${controller.contactsCount.value} Contacts",
//                       style:
//                           const TextStyle(color: Colors.purple, fontSize: 13),
//                     ),
//                   ),
//                 ),

//               // إظهار TextField فقط إذا كانت isSearchVisible = true
//               if (isSearchVisible.value)
//                 Expanded(
//                   flex: 2,
//                   child: TextField(
//                     onChanged: controller.searchContactsByName,
//                     decoration: const InputDecoration(
//                       hintText: 'Search Contacts',
//                       prefixIcon: Icon(Icons.search),
//                       border: InputBorder.none, // حذف الحواف تمامًا
//                     ),
//                     style: const TextStyle(
//                         fontSize: 14), // حجم النص داخل TextField
//                   ),
//                 ),
//               if (!isSearchVisible.value)
//                 TextButton(
//                   onPressed: () {
//                     controller.fetchAndSendContacts();
//                     Get.offNamed(AppRoute.selectContacts);
//                   },
//                   child: const Text(
//                     "Refresh",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),

//               // إضافة أيقونة البحث التي تقوم بالتبديل بين حالة isSearchVisible
//               IconButton(
//                 icon: const Icon(Icons.search),
//                 onPressed: () {
//                   // التبديل بين إظهار وإخفاء حقل البحث
//                   isSearchVisible.value = !isSearchVisible.value;
//                 },
//               ),
//             ],
//           );
//         }),
//       ),
//       body: Obx(() {
//         // تحقق من حالة الطلب فقط في هذا الجزء
//         if (controller.statusRequest.value == StatusRequest.loading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (controller.statusRequest.value == StatusRequest.failure) {
//           return const Center(child: Text("فشل تحميل المستخدمين"));
//         } else if (controller.searchResults.isEmpty &&
//             controller.isSearchVisible.value) {
//           return const Center(child: Text("لا يوجد نتائج مطابقة"));
//         }

//         // عرض الأسماء بعد معالجة الحالة
//         return Obx(() => ListView.builder(
//               itemCount: controller.searchResults.isNotEmpty
//                   ? controller.searchResults.length
//                   : controller.availableUsers.length +
//                       controller.contactsToInvite.length,
//               itemBuilder: (context, index) {
//                 if (controller.searchResults.isNotEmpty) {
//                   return buildContactTile(controller.searchResults[index]);
//                 }

//                 if (index == controller.availableUsers.length) {
//                   return const Padding(
//                     padding: EdgeInsets.only(left: 20, top: 10),
//                     child: Text(
//                       "Invite to ChatApp",
//                       style: TextStyle(
//                           color: Color.fromARGB(255, 198, 105, 215),
//                           fontSize: 14),
//                     ),
//                   );
//                 }

//                 if (index < controller.availableUsers.length) {
//                   return buildContactTile(controller.availableUsers[index]);
//                 }

//                 final inviteIndex =
//                     index - controller.availableUsers.length - 1;
//                 return buildContactTile(
//                   controller.contactsToInvite[inviteIndex],
//                   trailingText: "Invite",
//                 );
//               },
//             ));
//       }),
//     );
//   }
// }
