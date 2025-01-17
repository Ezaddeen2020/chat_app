// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:chatapp/controller/screens/user_controller.dart';
import 'package:chatapp/core/classes/status_request.dart';
import 'package:chatapp/core/constant/routes.dart';
import 'package:chatapp/core/functions/handling_data.dart';
import 'package:chatapp/data/datasource/remote/chat/chat_data.dart';
import 'package:chatapp/data/models/chat_model.dart';
import 'package:chatapp/data/models/chat_user_model.dart';
import 'package:chatapp/socket/socket_class.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final ChatData chatData = ChatData(Get.find());
  final UserController userController = Get.find<UserController>();
  final PageController pageController = PageController(initialPage: 1);

  StatusRequest statusRequest = StatusRequest.none;
  var chatUserslist = <ChatUserModel>[].obs;

  final selectedIndex = <int>[].obs;
  final isSelected = false.obs;
  List<int> onlineUsers = [];
  var pageIndex = 1.obs;

  //=========  Initial page   ===============================//
  @override
  void onInit() {
    super.onInit();
    fetchData();
    socketListen();
  }

//============= Messages Selected to Deleted =================//

  void toggleSelect(int index) {
    if (selectedIndex.contains(index)) {
      selectedIndex.remove(index);
    } else {
      selectedIndex.add(index);
    }
    //if no selected items
    if (selectedIndex.isEmpty) {
      isSelected.value = false;
    }
  }

  void toggleSelectAll() {
    if (selectedIndex.length != chatUserslist.length) {
      selectedIndex.value = List.generate(chatUserslist.length, (index) => index);
    } else {
      selectedIndex.clear();
    }
  }

  void cancelSelect() {
    isSelected.value = false;
    selectedIndex.clear();
  }

  void deleteSelected() {
    selectedIndex.sort((a, b) => b.compareTo(a));
    for (int index in selectedIndex) {
      chatUserslist.removeAt(index);
    }
    cancelSelect();
  }

//============= Listener Functions of Socket =================//
  void socketListen() {
    socket?.on('message', (data) => msgSocketEvent(data));
    socket?.on('online', (data) {
      if (data is List) {
        onlineUsers = data
            .map(
              (e) => int.parse(e.toString()),
            )
            .toList();
        update();
        onlineSocket();
      }
    });
  }

//============= Messages From Socket =================//
  void msgSocketEvent(dynamic data) {
    log("$data'''''''''''''''''''''''''''''''''");

    if (data is List) {
      for (var element in data) {
        final ChatUserModel userChatModel = ChatUserModel.fromJson(element);
        addListMsg(
          userChatModel.chatModellist ?? [],
          userChatModel.user.userId,
          revers: true,
        );
        // log(userChatModel.toJson().toString()+"'5555555%%%%%%%%%%%%%%%%%%%'")
        update();
      }
    } else {
      print("Unexpected data type: ${data.runtimeType}");
    }
  }

//============= Check Online From Socket =================//
  void onlineSocket() {
    log("${onlineUsers}8888888");

    chatUserslist.assignAll(chatUserslist.map((element) {
      // log("${element.user.userId}****************************************");
      if (onlineUsers.contains(element.user.userId)) {
        element.isOnline = true;
      } else if (onlineUsers.contains(element.user.userId) &&
          element.chatModellist!.first.message == true) {
        log("Seen Message");
      } else {
        element.isOnline = false;
      }
      return element;
    }).toList());

    update();
    log("${chatUserslist.map(
          (element) => element.toJson(),
        ).toList()}9999999999999999999999999999999999999999999");
  }

  //=========  Manging the pages locations   =========//
  void onPageChanged(int index) {
    pageIndex.value = index;
    update();
  }

  //==========   Fetching chatting Data (Menu of users)  ==========//
  // Future<void> fetchData() async {
  //   try {
  //     statusRequest = StatusRequest.loading;
  //     update();

  //     if (userController.userModel != null) {
  //       final response = await ChatData.fetchdata(userController.userModel!.userId);
  //       final res = await ChatData.getNotViewMsg(userController.userModel!.userId);
  //       statusRequest = handlingData(response);

  //       if (statusRequest == StatusRequest.success && response['status'] == "success") {
  //         chatUserslist.value = (response['data'] as List)
  //             .map((e) => ChatUserModel.fromJson(e))
  //             .whereType<ChatUserModel>()
  //             .toList();
  //         (res['data'] as List).map((e) {
  //           var model = ChatModel.fromJson(e);
  //           addListMsg([model], model.senderId);
  //           return model;
  //         }).toList();
  //       } else {
  //         Get.defaultDialog(
  //             title: "Warning", middleText: "Failed to fetch data or check the IP of internet");
  //         statusRequest = StatusRequest.failure;
  //       }
  //     } else {
  //       print('There are no Chatting Messages');
  //     }
  //   } catch (e) {
  //     Get.defaultDialog(title: "Error", middleText: e.toString());
  //     statusRequest = StatusRequest.failure;
  //   }
  //   update();
  //   onlineSocket();
  // }

  Future<void> fetchData() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      if (userController.userModel != null) {
        final response = await chatData.fetchdata(userController.userModel!.userId);
        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success && response['status'] == "success") {
          chatUserslist.value = (response['data'] as List)
              .map((e) => ChatUserModel.fromJson(e))
              .whereType<ChatUserModel>()
              .toList();

          // إضافة الرسائل المقروءة وغير المقروءة
          (response['data'] as List).map((e) {
            var model = ChatModel.fromJson(e);
            // إضافة الرسائل إلى القائمة حسب حالة المشاهدة
            if (e['msg_status'] == 'unviewed') {
              addListMsg([model], model.senderId, revers: true); // رسائل غير مقروءة
            } else {
              addListMsg([model], model.senderId); // رسائل مقروءة
            }
            return model;
          }).toList();
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "Failed to fetch data or check the IP of internet");
          statusRequest = StatusRequest.failure;
        }
      } else {
        print('There are no Chatting Messages');
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
      statusRequest = StatusRequest.failure;
    }
    update();
    onlineSocket();
  }

//===================== Pass the Data between Pages ==========================//
  void goToIndiviual(ChatUserModel userchatmodel) {
    // تحقق مما إذا كانت هناك دردشة سابقة مع المستخدم
    final existingChat =
        chatUserslist.firstWhereOrNull((loop) => loop.user.userId == userchatmodel.user.userId);

    if (existingChat != null) {
      // إذا كانت هناك دردشة موجودة، قم بتمرير الرسائل إلى صفحة الدردشة
      Get.toNamed(AppRoute.indiviualScreen, arguments: {
        "keyData": existingChat.toJson(),
        // "messages": existingChat.chatModellist
      });
    } else {
      // إذا لم تكن هناك دردشة، يمكنك تمرير النموذج فقط
      Get.toNamed(AppRoute.indiviualScreen, arguments: {"keyData": userchatmodel.toJson()});
    }
  }

  //=========  Refresh the List of Messsages for users   =========//الهدف: هذه الدالة تقوم بتحديث قائمة الرسائل الخاصة بمستخدم معين، وليس المستخدم نفسه.
  void addListMsg(List<ChatModel> listChat, int receiverId, {bool revers = false}) {
    //تحديد موقع المستخدم في قائمة الدردشة
    final index = chatUserslist.indexWhere((user) => user.user.userId == receiverId);
    if (index > -1) {
      final existMsg = chatUserslist[index].chatModellist ?? [];
      //لتسهيل التحقق من وجود الرسالة لاحقًا. Set إلى مجموعةmsgKey تحويل مفاتيح الرسائل الموجودة
      final existMsgKeys = existMsg.map((msg) => msg.msgKey).toSet();
      //إضافة الرسائل الجديدة أو تحديث الرسائل الموجودة

      for (var chat in listChat) {
        if (!existMsg.any((msg) => msg.msgKey == chat.msgKey)) {
          if (revers) {
            existMsg.insert(0, chat);
            // existMsg.add(chat);
          } else {
            existMsg.add(chat);
          }
          existMsgKeys.add(chat.msgKey);
        } else {
          var ind = existMsg.indexWhere((element) => element.msgKey == chat.msgKey);
          existMsg[ind] = chat;
        }
      }
      chatUserslist[index].chatModellist = existMsg;
    }
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

// //=====================   ==========================//
//   void addDataMsg(ChatUserModel userChatModel) {
//     final index = chatUserslist
//         .indexWhere((loop) => loop.user.userId == userChatModel.user.userId);

//     if (index > -1) {
//       final existMsg = chatUserslist[index].chatModellist ?? [];
//       final newMsg = userChatModel.chatModellist ?? [];
//       final existMsgKeys = existMsg.map((msg) => msg.msgKey).toSet();

//       for (var message in newMsg) {
//         if (!existMsg.any((msg) => msg.msgKey == message.msgKey)) {
//           existMsg.insert(0, message);
//           // existMsg.add(message);
//           existMsgKeys.add(message.msgKey);
//         } else {
//           var ind = existMsg
//               .indexWhere((element) => element.msgKey == message.msgKey);
//           existMsg[ind] = message;
//         }
//       }

//       chatUserslist[index].chatModellist =
//           existMsg; //   existMsg تحديث قائمة الرسائل الخاصة بالمستخدم عند الفهرس بقائمة جديدة تسمى
//     } else {
//       chatUserslist.add(userChatModel);
//     }
//     update();
//   }


// Future<void> fetchData() async {
//   try {
//     statusRequest = StatusRequest.loading;
//     update();

//     if (userController.userModel != null) {
//       final response = await ChatData.fetchdata(userController.userModel!.userId);
//       statusRequest = handlingData(response);

//       if (statusRequest == StatusRequest.success && response['status'] == "success") {
//         chatUserslist.value = (response['data'] as List)
//             .map((e) => ChatUserModel.fromJson(e))
//             .whereType<ChatUserModel>()
//             .toList();

//         // إضافة الرسائل المقروءة وغير المقروءة
//         (response['data'] as List).map((e) {
//           var model = ChatModel.fromJson(e);
//           // إضافة الرسائل إلى القائمة حسب حالة المشاهدة
//           if (e['msg_status'] == 'unviewed') {
//             addListMsg([model], model.senderId, revers: true);  // رسائل غير مقروءة
//           } else {
//             addListMsg([model], model.senderId);  // رسائل مقروءة
//           }
//           return model;
//         }).toList();
//       } else {
//         Get.defaultDialog(
//             title: "Warning", middleText: "Failed to fetch data or check the IP of internet");
//         statusRequest = StatusRequest.failure;
//       }
//     } else {
//       print('There are no Chatting Messages');
//     }
//   } catch (e) {
//     Get.defaultDialog(title: "Error", middleText: e.toString());
//     statusRequest = StatusRequest.failure;
//   }
//   update();
//   onlineSocket();
// }
