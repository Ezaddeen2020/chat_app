import 'package:chatapp/data/datasource/remote/chat/chat_data.dart';
import 'package:chatapp/controller/screens/user_controller.dart';
import 'package:chatapp/core/functions/handling_data.dart';
import 'package:chatapp/core/classes/status_request.dart';
import 'package:chatapp/data/models/chat_user_model.dart';
import 'package:chatapp/data/models/messages_model.dart';
import 'package:chatapp/controller/home_controller.dart';
import 'package:chatapp/data/models/chat_model.dart';
import 'package:chatapp/data/models/user_model.dart';
import 'package:chatapp/socket/socket_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:developer';

class MessageController extends GetxController {
  final TextEditingController myController = TextEditingController();
  final homeController = Get.find<HomeController>();

  // final AddMessages addMessages = AddMessages(Get.find());
  final ChatData chatData = ChatData(Get.find());
  // final LoadMsgData loadmsgData = LoadMsgData(Get.find());
  // final DeleteMsgData deleteMsgVar = DeleteMsgData(Get.find());
  final userController = Get.find<UserController>();
  StatusRequest statusRequest = StatusRequest.none;
  final focusNode = FocusNode();
  var showEmojiPicker = false.obs;
  var sendButton = false.obs;
  ChatModel? msgModel;
  UserModel? userModel;
  bool isReplay = false;
  bool isEdit = false;

  final selectedIndex = <int>[].obs;
  final isSelected = false.obs;
  List<int> onlineUsers = [];

  ChatModel? getModelReplay(String? msgKey) {
    int index =
        homeController.chatUserslist.indexWhere((user) => user.user.userId == userModel!.userId);
    if (index > -1) {
      var model = homeController.chatUserslist[index].chatModellist
          ?.where(
            (element) => element.msgKey == msgKey,
          )
          .firstOrNull;
      return model;
    }
    return null;
  }

  void replayToMsg(ChatModel chat) {
    msgModel = chat;
    isEdit = false;
    isReplay = true;
    focusNode.requestFocus();
    update();
  }

  void sendReply(String message, String msgKey) {
    if (msgModel != null) {
      addMsg(message);
      update();
      hideContainer();
    }
  }

  void copyMessage(String messageContent, BuildContext context) {
    Clipboard.setData(ClipboardData(text: messageContent));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Message copied to clipboard!"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

//============= Messages Selected to Deleted =================//
  void toggleSelectMsg(int index) {
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

  void toggleSelectAllMsg() {
    bool isAllSelected = selectedIndex.length ==
        homeController.chatUserslist
            .fold<int>(0, (sum, user) => sum + (user.chatModellist?.length ?? 0));
    if (!isAllSelected) {
      selectedIndex.value = List.generate(
          homeController.chatUserslist
              .fold<int>(0, (sum, user) => sum + (user.chatModellist?.length ?? 0)),
          (index) => index);
    } else {
      // مسح التحديد
      selectedIndex.clear();
    }
  }

  void cancelSelectMsg() {
    isSelected.value = false;
    selectedIndex.clear();
  }

  void deleteSelectedMsg() {
    selectedIndex.sort((a, b) => b.compareTo(a));
    for (int index in selectedIndex) {
      homeController.chatUserslist.removeAt(index);
    }
    cancelSelectMsg();
  }

  @override
  void onInit() {
    var userChatModel = ChatUserModel.fromJsonlocal(Get.arguments["keyData"]);
    userModel = userChatModel.user;
    // if (userChatModel.chatModellist!.length <= 20) {
    loadMsgFun();
    // }
    super.onInit();
  }

  void toggleEmojiPicker() {
    showEmojiPicker.value = !showEmojiPicker.value;
  }

  //===================== Load Messages ==========================//
  Future<void> loadMsgFun() async {
    statusRequest = StatusRequest.loading;
    update();
    var senderId = userController.userModel!.userId;
    var recieverId = userModel?.userId;

    // if (recieverId != null) return;

    final response = await chatData.loadMsg(senderId, recieverId!);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success && response['status'] == "success") {
      List data = response['data'];
      var msgModleList = data.map((e) => ChatModel.fromJson(e)).toList();
      homeController.addListMsg(msgModleList, recieverId);
    } else {
      Get.defaultDialog(title: "Warning", middleText: "Failed to load messages.");
      statusRequest = StatusRequest.failure;
    }

    update();
    // ChatModel? msgViewModel;
    // msgView(msgViewModel);
  }

  //===================== Add Messages ==========================//
  void addMsg(String message) async {
    var localTime = DateTime.now();
    final isOnlySpace = message.trim().isEmpty;
    var model = ChatModel(
      msgId: 0,
      senderId: userController.userModel!.userId,
      receiverId: userModel?.userId ?? 0,
      message: isOnlySpace
          ? MessageModel(msg: '', replayMsg: msgModel?.msgKey)
          : MessageModel(msg: message, replayMsg: msgModel?.msgKey),
      msgType: "Text",
      msgKey: '${DateTime.now().millisecondsSinceEpoch}',
      timestamp: localTime,
      msgView: false,
    );
    SocketClass.sendMessage(model, userModel!);
    // تحديث واجهة المستخدم
    homeController.addListMsg([model], userModel!.userId, revers: true);
    sendButton.value = false;
    hideContainer();
    update();
    log('==============  تم إرسال الرسالة بوقت محلي : ${model.timestamp}==========');
    final response = await chatData.addMsgFun(model);

    if (StatusRequest.success == statusRequest && response['status'] == "success") {
      log('Response from server: ${response.toString()}');
    }
  }

  //=========================== Socket Functions ===============================//
  void msgView(ChatModel msgViewModel) async {
    msgViewModel = msgViewModel.copyWith(msgView: true);
    SocketClass.sendMessage(msgViewModel, userModel!);
    final res = await chatData.editMsgData(msgViewModel);
    if (StatusRequest.success == statusRequest && res['status'] == "success") {
      log('Response from server: ${res.toString()}--------------------------------------');
    }
  }

  // //===================================    Edit proccessing    ==============================//
  void showEditContainer(ChatModel model, {bool replayMsg = false}) {
    //   // تأكد من وجود النموذج ووجود الرسالة ثم تحديث المتحكم
    if (model.message?.msg != null) {
      if (replayMsg) {
        isEdit = false;
        isReplay = true;
      } else {
        isEdit = true;
        isReplay = false;
        myController.text = model.message!.msg;
      }
      msgModel = model; // حفظ النموذج المعدل

      update();
    }
  }

  void editMessage(String editMsg, {bool isDele = false}) async {
    if (msgModel == null && editMsg.isNotEmpty) return;

    msgModel?.message = msgModel?.message?.copyWith(
      msg: editMsg,
      editMsgbyKey: isDele ? msgModel!.message!.editMsgbyKey : true,
      delMsgbykey: isDele,
    );

    log("${msgModel!.toJson()}#########################333333333");

    SocketClass.sendMessage(msgModel!, userModel!);
    // log(msgModel!.toJson().toString() + "********************************");
    homeController.addListMsg([msgModel!], userModel!.userId);
    sendButton.value = false;
    var editModel = msgModel;
    hideContainer();
    update();

    final response = await chatData.editMsgData(editModel!);
    if (StatusRequest.success == statusRequest && response['status'] == "success") {
      log("${response}edit_Message from server77777777 ");
    } else {
      Get.snackbar("Error", "Failed to update the message");
    }

    update();
  }

  hideContainer() {
    msgModel = null;
    msgModel = null;
    isReplay = false;
    isEdit = false;
    myController.clear();
    update();
  }

  //===================================    Delete proccessing    ==============================//
  void delMsgFun(ChatModel delMsg) async {
    // log(msgdelKey);
    msgModel = delMsg;
    editMessage(msgModel!.message!.msg, isDele: true);
  }
}











// import 'package:chatapp/core/classes/crud.dart';
// import 'package:chatapp/data/datasource/remote/chat/delete_msg_data.dart';
// import 'package:chatapp/data/datasource/remote/chat/edit_msg_data.dart';
// import 'package:chatapp/data/datasource/remote/chat/load_msg_data.dart';
// import 'package:chatapp/data/datasource/remote/chat/message_data.dart';
// import 'package:chatapp/controller/screens/user_controller.dart';
// import 'package:chatapp/core/functions/handling_data.dart';
// import 'package:chatapp/core/classes/status_request.dart';
// import 'package:chatapp/data/models/chat_user_model.dart';
// import 'package:chatapp/data/models/messages_model.dart';
// import 'package:chatapp/controller/home_controller.dart';
// import 'package:chatapp/data/models/chat_model.dart';
// import 'package:chatapp/data/models/user_model.dart';
// import 'package:chatapp/links_api.dart';
// import 'package:chatapp/socket/socket_class.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'dart:developer';

// class MessageController extends GetxController {
//   final TextEditingController myController = TextEditingController();
//   final homeController = Get.find<HomeController>();

//   final AddMessages addMessages = AddMessages(Get.find());
//   final EditMsgData editMessages = EditMsgData(Get.find());
//   final LoadMsgData loadmsgData = LoadMsgData(Get.find());
//   final DeleteMsgData deleteMsgVar = DeleteMsgData(Get.find());
//   final userController = Get.find<UserController>();
//   StatusRequest statusRequest = StatusRequest.none;
//   final focusNode = FocusNode();
//   var showEmojiPicker = false.obs;
//   var sendButton = false.obs;
//   ChatModel? msgModel;
//   UserModel? userModel;
//   bool isReplay = false;
//   bool isEdit = false;

//   final selectedIndex = <int>[].obs;
//   final isSelected = false.obs;
//   List<int> onlineUsers = [];

//   ChatModel? getModelReplay(String? msgKey) {
//     int index =
//         homeController.chatUserslist.indexWhere((user) => user.user.userId == userModel!.userId);
//     if (index > -1) {
//       var model = homeController.chatUserslist[index].chatModellist
//           ?.where(
//             (element) => element.msgKey == msgKey,
//           )
//           .firstOrNull;
//       return model;
//     }
//     return null;
//   }

//   void replayToMsg(ChatModel chat) {
//     msgModel = chat;
//     isEdit = false;
//     isReplay = true;
//     focusNode.requestFocus();
//     update();
//   }

//   void sendReply(String message, String msgKey) {
//     if (msgModel != null) {
//       addMsg(message);
//       update();
//       hideContainer();
//     }
//   }

//   void copyMessage(String messageContent, BuildContext context) {
//     Clipboard.setData(ClipboardData(text: messageContent));
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Message copied to clipboard!"),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

// //============= Messages Selected to Deleted =================//
//   void toggleSelectMsg(int index) {
//     if (selectedIndex.contains(index)) {
//       selectedIndex.remove(index);
//     } else {
//       selectedIndex.add(index);
//     }

//     //if no selected items
//     if (selectedIndex.isEmpty) {
//       isSelected.value = false;
//     }
//   }

//   void toggleSelectAllMsg() {
//     bool isAllSelected = selectedIndex.length ==
//         homeController.chatUserslist
//             .fold<int>(0, (sum, user) => sum + (user.chatModellist?.length ?? 0));
//     if (!isAllSelected) {
//       selectedIndex.value = List.generate(
//           homeController.chatUserslist
//               .fold<int>(0, (sum, user) => sum + (user.chatModellist?.length ?? 0)),
//           (index) => index);
//     } else {
//       // مسح التحديد
//       selectedIndex.clear();
//     }
//   }

//   void cancelSelectMsg() {
//     isSelected.value = false;
//     selectedIndex.clear();
//   }

//   void deleteSelectedMsg() {
//     selectedIndex.sort((a, b) => b.compareTo(a));
//     for (int index in selectedIndex) {
//       homeController.chatUserslist.removeAt(index);
//     }
//     cancelSelectMsg();
//   }

//   @override
//   void onInit() {
//     var userChatModel = ChatUserModel.fromJsonlocal(Get.arguments["keyData"]);
//     userModel = userChatModel.user;

//     // if (userChatModel.chatModellist!.length <= 20) {
//     loadMsgFun();
//     // }
//     super.onInit();
//   }

//   void toggleEmojiPicker() {
//     showEmojiPicker.value = !showEmojiPicker.value;
//   }

//   //=======================================  load Messages  ======================================//
//   Future<void> loadMsgFun() async {
//     statusRequest = StatusRequest.loading;
//     update();

//     final senderId = userController.userModel!.userId;
//     final receiverId = userModel?.userId;
//     // if (msgViewModel.msgView) return;

//     // if (receiverId == null) return;

//     try {
//       // تحديث حالة الرسائل غير المقروءة
//       // if(){
//       // await loadmsgData.markMsgRead(senderId, receiverId!);
//       // }
//       // تحميل الرسائل
//       final response = await loadmsgData.loadMsg(senderId, receiverId!);
//       log(response.toString() + "load msg00000000000000000000");
//       statusRequest = handlingData(response);

//       if (statusRequest == StatusRequest.success && response['status'] == "success") {
//         final msgModelList = (response['data'] as List).map((e) => ChatModel.fromJson(e)).toList();
//         homeController.addListMsg(msgModelList, receiverId, isMsgRead: true);
//       } else {
//         Get.defaultDialog(title: "Warning", middleText: "Failed to load messages.");
//         statusRequest = StatusRequest.failure;
//       }
//     } catch (e) {
//       print('Error: $e');
//       statusRequest = StatusRequest.failure;
//     }

//     update();
//   }

//   //===================== Add Messages ==========================//
//   void addMsg(String message) async {
//     var localTime = DateTime.now();
//     final isOnlySpace = message.trim().isEmpty;
//     var model = ChatModel(
//       msgId: 0,
//       senderId: userController.userModel!.userId,
//       receiverId: userModel?.userId ?? 0,
//       message: isOnlySpace
//           ? MessageModel(msg: '', replayMsg: msgModel?.msgKey)
//           : MessageModel(msg: message, replayMsg: msgModel?.msgKey),
//       msgType: "Text",
//       msgKey: '${DateTime.now().millisecondsSinceEpoch}',
//       timestamp: localTime,
//       msgView: false,
//     );
//     SocketClass.sendMessage(model, userModel!);
//     // تحديث واجهة المستخدم
//     homeController.addListMsg([model], userModel!.userId, revers: true);
//     sendButton.value = false;
//     hideContainer();
//     update();
//     log('==============  تم إرسال الرسالة بوقت محلي : ${model.timestamp}==========');
//     final response = await addMessages.addMsgFun(model);

//     if (StatusRequest.success == statusRequest && response['status'] == "success") {
//       log('Response from server: ${response.toString()}');
//     }
//   }

//   //=========================== Messages Views Function ===============================//
//   void msgView(ChatModel msgViewModel) async {
//     // if (msgViewModel.msgView) return;
//     // if (msgViewModel != null) {

//     // // }
//     //     msgModel?.message = msgModel?.message?.copyWith(
//     //     msg: editMsg,
//     //     editMsgbyKey: isDele ? msgModel!.message!.editMsgbyKey : true,
//     //     delMsgbykey: isDele);

//     log(msgViewModel.toJson().toString() + "*************************");
//     msgModel = msgViewModel.copyWith(msgView: true);
//     // SocketClass.sendMessage(msgViewModel, userModel!);

//     // Emit mark_as_read event to the server
//     socket?.emit('mark_as_read', {
//       'msgKey': msgViewModel.msgKey,
//       'receiverId': msgViewModel.receiverId,
//       'senderId': msgViewModel.senderId,
//     });

//     final res = await editMessages.editMsgData(msgViewModel);
//     if (StatusRequest.success == statusRequest && res['status'] == "success") {
//       log('Message viewed and updated on server');
//     }
//     update();
//   }

//   //==============================   Edit proccessing       ======================================//
//   void showEditContainer(ChatModel model, {bool replayMsg = false}) {
//     //   // تأكد من وجود النموذج ووجود الرسالة ثم تحديث المتحكم
//     if (model.message?.msg != null) {
//       if (replayMsg) {
//         isEdit = false;
//         isReplay = true;
//       } else {
//         isEdit = true;
//         isReplay = false;
//         myController.text = model.message!.msg;
//       }
//       msgModel = model; // حفظ النموذج المعدل

//       update();
//     }
//   }

//   void editMessage(String editMsg, {bool isDele = false}) async {
//     if (msgModel == null && editMsg.isNotEmpty) return;

//     msgModel?.message = msgModel?.message?.copyWith(
//         msg: editMsg,
//         editMsgbyKey: isDele ? msgModel!.message!.editMsgbyKey : true,
//         delMsgbykey: isDele);

//     log("${msgModel!.toJson()}#########################333333333");

//     SocketClass.sendMessage(msgModel!, userModel!);
//     // log(msgModel!.toJson().toString() + "********************************");
//     homeController.addListMsg([msgModel!], userModel!.userId);
//     sendButton.value = false;
//     var editModel = msgModel;
//     hideContainer();
//     update();

//     final response = await editMessages.editMsgData(editModel!);
//     if (StatusRequest.success == statusRequest && response['status'] == "success") {
//       log("${response}edit_Message from server77777777 ");
//     } else {
//       Get.snackbar("Error", "Failed to update the message");
//     }

//     update();
//   }

//   hideContainer() {
//     msgModel = null;
//     msgModel = null;
//     isReplay = false;
//     isEdit = false;
//     myController.clear();
//     update();
//   }

//   //===================================    Delete proccessing    ==============================//
//   void delMsgFun(ChatModel delMsg) async {
//     // log(msgdelKey);
//     msgModel = delMsg;
//     editMessage(msgModel!.message!.msg, isDele: true);
//   }
// }

//     // log(msgdeleted);
//     // if (msgModel == null) return;

//     // msgModel = msgModel!.copyWith(
//     //   message: MessageModel(msg: msgdeleted, delMsgbykey: true),
//     // );
//     // log("${msgModel!.toJson()}#########################000000000000000000000");

//     // SocketClass.sendMessage(msgModel!, userModel!);
//     // log("${msgModel!.toJson()}#########################44444");

//     // homeController.addListMsg([msgModel!], userModel!.userId);
//     // var delModel = msgModel;

//     // update();

//     // int index = homeController.chatUserslist
//     //     .indexWhere((user) => user.user.userId == userModel!.userId);
//     // int indexMsg = homeController.chatUserslist[index].chatModellist!
//     //     .indexWhere((msg) => msg.msgKey == msgdelKey);
//     // update();

//     // homeController.chatUserslist[index].chatModellist!.removeAt(indexMsg);
//     // homeController.chatUserslist[index].chatModellist![indexMsg].message!
//     //     .delMsgbykey = true;
//     // homeController.update();

//     // update();

//     // var selectedMessage =
//     //     homeController.chatUserslist[index].chatModellist![indexMsg];
//     // SocketClass.sendMessage(msgModel!, userModel!);
//     // homeController.addListMsg([selectedMessage], userModel!.userId);

//     // log("${selectedMessage.toJson()}+++++++++++++++++++++++++++++++++");

//     // selectedMessage.message?.delMsgbykey = true;
//     // update();
//     // homeController.update();
//     // log("${selectedMessage.toJson()}+++++++++++++++++++++++++++++++++");
//     // حذف الرسالة من الخادم
//     // final response = await deleteMsgVar.delMsgData(selectedMessage);
//     // if (handlingData(response) == StatusRequest.success &&
//     //     response["status"] == "success") {
//     //   log("Message deleted successfully from server.");
//     // } else {
//     //   Get.snackbar("Error", "Failed to delete the message");
//     // }
//     // update();
// //   }
// // }
