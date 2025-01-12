// import 'package:chat_application/controller/screens/user_controller.dart';
// import 'package:chat_application/core/classes/status_request.dart';
// import 'package:chat_application/core/functions/handling_data.dart';
// import 'package:chat_application/data/datasource/remote/chat/fetch_user_data.dart';
// import 'package:chat_application/data/models/chat_user_model.dart';
// import 'package:chat_application/data/models/user_model.dart';
// import 'package:get/get.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContactsController extends GetxController {
//   final FetchUserData fetchUserData = FetchUserData(Get.find());
//   final userController = Get.find<UserController>();
//   var availableUsers = <ChatUserModel>[].obs;
//   var contactsToInvite = <ChatUserModel>[].obs;
//   var searchResults = <ChatUserModel>[].obs; // نتائج البحث المخزنة
//   var contactsCount = 0.obs;
//   var statusRequest = StatusRequest.none.obs; // جعلها من نوع Rx<StatusRequest>
//   var searchText = ''.obs; // نص البحث الحالي
//   var isContactsLoaded = false.obs; // لتتبع حالة تحميل الأسماء
//   var isSearchVisible = false.obs; // متغير يتحكم في ظهور حقل البحث

//   @override
//   void onInit() {
//     super.onInit();
//     // تحقق إذا كانت الأسماء تم تحميلها بالفعل
//     if (!isContactsLoaded.value) {
//       fetchAndSendContacts(); // استدعاء الدالة لتحميل الأسماء
//     }
//   }

//   // جلب جهات الاتصال ومعالجتها وإرسالها إلى السيرفر
//   Future<void> fetchAndSendContacts() async {
//     statusRequest.value = StatusRequest.loading; // تعديل القيمة
//     update();

//     if (await _requestContactsPermission()) {
//       try {
//         var contacts = await _getContactsInBackground();
//         contactsCount.value = contacts.length;
//         print("عدد الأسماء المسترجعة: ${contactsCount.value}");

//         // تصفية جهات الاتصال وتحديد المتاحة فقط
//         List<ChatUserModel> tempAvailableUsers = _filterContacts(contacts);

//         var response =
//             await fetchUserData.fetchAndSendContacts(tempAvailableUsers);
//         statusRequest.value = handlingData(response);

//         if (statusRequest.value == StatusRequest.success &&
//             response != null &&
//             response['status'] == 'success') {
//           _processResponseData(response); // معالجة بيانات الرد من السيرفر
//         } else {
//           statusRequest.value = StatusRequest.failure;
//         }
//       } catch (e) {
//         print("خطأ في جلب الأسماء: $e");
//         statusRequest.value = StatusRequest.failure;
//       }
//     } else {
//       print("لم يتم منح الإذن للوصول إلى جهات الاتصال");
//       statusRequest.value = StatusRequest.failure;
//     }

//     statusRequest.value =
//         StatusRequest.none; // إعادة حالة التحميل إلى الوضع الطبيعي
//     update();
//     isContactsLoaded.value = true; // بعد التحميل، تغيير الحالة
//   }

//   Future<bool> _requestContactsPermission() async {
//     var status = await Permission.contacts.status;
//     if (!status.isGranted) {
//       status = await Permission.contacts.request();
//     }
//     return status.isGranted;
//   }

//   List<ChatUserModel> _filterContacts(Iterable<Contact> contacts) {
//     return contacts
//         .where((contact) =>
//             contact.displayName != null &&
//             contact.displayName!.trim().isNotEmpty &&
//             contact.phones != null &&
//             contact.phones!.isNotEmpty &&
//             contact.phones!.first.value != null &&
//             contact.phones!.first.value!.trim().isNotEmpty)
//         .map((contact) => ChatUserModel(
//               user: UserModel.passWith(
//                 userId: contact.hashCode,
//                 userName: contact.displayName!.trim(),
//                 userPhone: contact.phones!.first.value!.trim(),
//               ),
//             ))
//         .toList()
//       ..sort((a, b) =>
//           a.user.userName.compareTo(b.user.userName)); // ترتيب الأسماء
//   }

//   void _processResponseData(Map<String, dynamic> response) {
//     Set<String> phoneNumbersSet = {};
//     Set<int> userIdsSet = {};

//     availableUsers.clear();
//     contactsToInvite.clear();

//     if (response['data'] != null) {
//       for (var userData in response['data']) {
//         ChatUserModel newUser = ChatUserModel(
//           user: UserModel.fromJson(userData),
//         );

//         if (!phoneNumbersSet.contains(newUser.user.userPhone) &&
//             !userIdsSet.contains(newUser.user.userId)) {
//           availableUsers.add(newUser);
//           phoneNumbersSet.add(newUser.user.userPhone);
//           userIdsSet.add(newUser.user.userId);
//         }
//       }
//     } else {
//       print("لا توجد بيانات في response['data']");
//     }

//     if (response['to_invite'] != null) {
//       contactsToInvite.addAll(response['to_invite']
//           .map<ChatUserModel>((inviteData) => ChatUserModel(
//                 user: UserModel.passWith(
//                   userName: inviteData['user_name'] ?? 'غير مسجل',
//                   userPhone: inviteData['user_phone'] ?? '',
//                 ),
//               )));
//     } else {
//       print("لا توجد بيانات في response['to_invite']");
//     }
//   }

//   // البحث عن جهات الاتصال في availableUsers و contactsToInvite
//   void searchContactsByName(String name) {
//     searchResults.clear();
//     searchText.value = name; // تخزين نص البحث الحالي

//     searchResults.addAll(availableUsers
//         .where((contact) =>
//             contact.user.userName.toLowerCase().contains(name.toLowerCase()))
//         .toList());

//     searchResults.addAll(contactsToInvite
//         .where((contact) =>
//             contact.user.userName.toLowerCase().contains(name.toLowerCase()))
//         .toList());

//     update();
//   }

//   // جلب الأرقام في خيط منفصل
//   Future<List<Contact>> _getContactsInBackground() async {
//     return await ContactsService.getContacts();
//   }
// }



// // Future<void> fetchAndSendContacts() async {
// //   statusRequest = StatusRequest.loading;
// //   update();

// //   if (await _requestContactsPermission()) {
// //     try {
// //       var contacts = await _getContactsInBackground();
// //       contactsCount.value = contacts.length;

// //       // تقسيم جهات الاتصال إلى دفعات
// //       int batchSize = 50; // حدد حجم الدفعة
// //       for (int i = 0; i < contacts.length; i += batchSize) {
// //         var batch = contacts.skip(i).take(batchSize).toList();
// //         List<ChatUserModel> tempAvailableUsers = _filterContacts(batch);

// //         // إرسال الدفعة إلى backend
// //         var response = await fetchUserData.fetchAndSendContacts(tempAvailableUsers);
// //         statusRequest = handlingData(response);

// //         if (statusRequest == StatusRequest.success &&
// //             response != null &&
// //             response['status'] == 'success') {
// //           _processResponseData(response);
// //         } else {
// //           statusRequest = StatusRequest.failure;
// //           break;
// //         }
// //       }
// //     } catch (e) {
// //       print("خطأ في جلب الأسماء: $e");
// //       statusRequest = StatusRequest.failure;
// //     }
// //   } else {
// //     print("لم يتم منح الإذن للوصول إلى جهات الاتصال");
// //     statusRequest = StatusRequest.failure;
// //   }

// //   update();
// // }