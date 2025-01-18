import 'package:chatapp/controller/home_controller.dart';
import 'package:chatapp/controller/screens/message_conttoller.dart';
import 'package:chatapp/view/Screens/home/indiviual_chat/appbar_chat.dart';
import 'package:chatapp/view/Screens/home/indiviual_chat/message_items.dart';
import 'package:chatapp/view/Screens/home/indiviual_chat/message_send.dart';
import 'package:flutter/material.dart';
import 'package:mc_utils/mc_utils.dart';
import 'package:swipe_to/swipe_to.dart';
// import 'package:mc_utils/mc_utils.dart';

class IndiviualScreen extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final MessageController messageController = Get.put(MessageController());
  IndiviualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/background.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const ChatAppBar(),
          body: Column(
            children: [
              Expanded(
                child: GetBuilder<HomeController>(builder: (controller) {
                  var chatuser = controller.chatUserslist
                      .where((p0) => p0.user.userId == messageController.userModel!.userId)
                      .firstOrNull;
                  return ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: chatuser?.chatModellist?.length,
                    itemBuilder: (context, index) {
                      var model = chatuser!.chatModellist![index];
                      // print('${model.msgView}*********${model.message?.toJson()}');
                      if (!model.msgView &&
                          model.senderId != messageController.userController.userModel?.userId) {
                        messageController.msgView(model);
                      }
                      return SwipeTo(
                        onRightSwipe: (details) => messageController.replayToMsg(model),
                        child: MessageItem(
                          message: model,
                          index: index,
                        ),
                      );
                    },
                  );
                }),
              ),
              const MessageInput(),
            ],
          ),
        ),
      ],
    );
  }
} 










// import 'package:chatapp/view/Screens/home/indiviual_chat/appbar_chat.dart';
// import 'package:chatapp/view/Screens/home/indiviual_chat/message_chat.dart';
// import 'package:chatapp/view/Screens/home/indiviual_chat/message_send.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:chatapp/controller/screens/indiviual_controller.dart';

// class IndiviualScreen extends StatelessWidget {
//   final TextEditingController myController = TextEditingController();
//   final ScrollController scrollController = ScrollController();

//   IndiviualScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(IndiviualControllerImp(), permanent: true);

//     return Stack(
//       children: [
//         Image.asset(
//           "assets/images/background.png",
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           fit: BoxFit.cover,
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: ChatAppBar(controller: controller),
//           body: Column(
//             children: [
//               Expanded(
//                 child: MessageList(
//                     controller: controller, scrollController: scrollController),
//               ),
//               MessageInput(controller: controller, myController: myController),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:chatapp/controller/screens/indiviual_controller.dart';
// import 'package:chatapp/view/Screens/camera/camera_screen.dart';
// import 'package:chatapp/view/Screens/camera/camera_view_screen.dart';
// import 'package:chatapp/view/Screens/indiviual_chat/real_chat_message/reply_message.dart';
// import 'package:chatapp/view/Screens/indiviual_chat/real_chat_message/send_image_card.dart';
// import 'package:chatapp/view/Screens/indiviual_chat/real_chat_message/send_message.dart';
// import 'package:chatapp/view/widgets/onboarding/emoji_picker.dart';
// import 'package:intl/intl.dart';

// // ignore: must_be_immutable
// class IndiviualScreen extends StatelessWidget {
//   IndiviualScreen({
//     super.key,
//   });

//   // bool show = false;

//   FocusNode focusnode = FocusNode();

//   // final TextEditingController mycontroller = TextEditingController();
//   //
//   // bool sendButton = false;

//   // List<MessageModel> messagesList = [];
//   // ScrollController scrollcontroller = ScrollController();
//   // final ChatUserModel? usermodel;

//   // ImagePicker picker = ImagePicker();
//   late XFile file;

//   int poptime = 0;

//   // final IndiviualControllerImp controller = Get.put(IndiviualControllerImp());

//   final TextEditingController myController = TextEditingController();

//   final ScrollController scrollController = ScrollController();

//   final ImagePicker picker = ImagePicker();

//   // @override
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(IndiviualControllerImp(), permanent: true);

//     String formattedTime =
//         DateFormat('hh:mm a').format(controller.userchatModel.chat.timestamp);

//     return Stack(
//       children: [
//         Image.asset(
//           "assets/images/background.png",
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           fit: BoxFit.cover,
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             leadingWidth: 70,
//             titleSpacing: 0,
//             leading: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.arrow_back, size: 24),
//                   SizedBox(width: 5),
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Colors.blueGrey,
//                     backgroundImage: AssetImage("assets/images/photo.JPG"),
//                   ),
//                 ],
//               ),
//             ),
//             title: Container(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     controller.userchatModel.user.userName,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.5,
//                         color: Colors.black),
//                   ),
//                   Text(
//                     formattedTime,
//                     style: const TextStyle(fontSize: 13.5),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
//               IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
//               PopupMenuButton<String>(
//                 onSelected: (value) {},
//                 itemBuilder: (BuildContext context) {
//                   return const [
//                     PopupMenuItem(
//                       value: "View Contact",
//                       child: Text("View Contact"),
//                     ),
//                     PopupMenuItem(
//                       value: "Media, Links, and docs",
//                       child: Text("Media, Links, and docs"),
//                     ),
//                     PopupMenuItem(
//                       value: "WhatsApp Web",
//                       child: Text("WhatsApp Web"),
//                     ),
//                     PopupMenuItem(
//                       value: "Search",
//                       child: Text("Search"),
//                     ),
//                     PopupMenuItem(
//                       value: "Mute Notification",
//                       child: Text("Mute Notification"),
//                     ),
//                     PopupMenuItem(
//                       value: "Wallpaper",
//                       child: Text("Wallpaper"),
//                     ),
//                   ];
//                 },
//               ),
//             ],
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: Obx(() => ListView.builder(
//                       shrinkWrap: true,
//                       controller: scrollController,
//                       itemCount: controller.messagesList.length + 1,
//                       itemBuilder: (context, index) {
//                         if (index == controller.messagesList.length) {
//                           return const SizedBox(height: 80);
//                         }
//                         var message = controller.messagesList[index];
//                         if (message.type == 'source') {
//                           return message.path.isNotEmpty
//                               ? SendImageCard(
//                                   path: message.path,
//                                   message: message.message,
//                                   time: message.time,
//                                   direction: ChatBubbleDirection.sender,
//                                 )
//                               : SendMessage(
//                                   sendmessage: message.message,
//                                   time: message.time,
//                                 );
//                         } else {
//                           return ReplyMessage(
//                             replymessage: message.message,
//                             time: message.time,
//                           );
//                         }
//                       },
//                     )),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Card(
//                             margin: const EdgeInsets.only(
//                                 left: 2, right: 2, bottom: 8),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25)),
//                             child: TextFormField(
//                               controller: myController,
//                               textAlignVertical: TextAlignVertical.center,
//                               keyboardType: TextInputType.multiline,
//                               maxLines: 5,
//                               minLines: 1,
//                               onChanged: (value) {
//                                 controller.sendButton.value = value.isNotEmpty;
//                               },
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "Type a message",
//                                 hintStyle: const TextStyle(color: Colors.grey),
//                                 prefixIcon: IconButton(
//                                   onPressed: () {
//                                     controller.toggleEmojiPicker();
//                                   },
//                                   icon: const Icon(Icons.emoji_emotions,
//                                       color: Colors.blueGrey),
//                                 ),
//                                 suffixIcon: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         showModalBottomSheet(
//                                           backgroundColor: Colors.transparent,
//                                           context: context,
//                                           builder: (builder) => bottomsheet(),
//                                         );
//                                       },
//                                       icon: const Icon(Icons.attach_file,
//                                           color: Colors.blueGrey),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         Get.to(() => CameraScreen());
//                                       },
//                                       icon: const Icon(Icons.camera_alt,
//                                           color: Colors.blueGrey),
//                                     ),
//                                   ],
//                                 ),
//                                 contentPadding: const EdgeInsets.all(5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               bottom: 8, right: 2, left: 2),
//                           child: CircleAvatar(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 15, 80, 53),
//                             radius: 25,
//                             child: Obx(() => IconButton(
//                                   onPressed: () {
//                                     if (controller.sendButton.value) {
//                                       controller.sendMessage(myController.text);
//                                       myController.clear();
//                                     }
//                                   },
//                                   icon: Icon(
//                                     controller.sendButton.value
//                                         ? Icons.send
//                                         : Icons.mic,
//                                     color: Colors.white,
//                                   ),
//                                 )),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Obx(() => controller.showEmojiPicker.value
//                         ? PickerWidget(myController: myController)
//                         : Container())
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget bottomsheet() {
//     return SizedBox(
//       height: 280,
//       width: Get.width,
//       child: Card(
//         margin: const EdgeInsets.all(18),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   createIcon(Icons.insert_drive_file, Colors.indigo, "Document",
//                       () {}),
//                   const SizedBox(width: 30),
//                   createIcon(Icons.camera_alt, Colors.pink, "Camera", () {
//                     Get.to(() => CameraScreen());
//                   }),
//                   const SizedBox(width: 30),
//                   createIcon(Icons.insert_photo, Colors.purple, "Gallery",
//                       () async {
//                     XFile file =
//                         (await picker.pickImage(source: ImageSource.gallery))!;
//                     Get.to(() => CameraView(imagePath: file.path));
//                   }),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   createIcon(Icons.headset, Colors.orange, "Audio", () {}),
//                   const SizedBox(width: 30),
//                   createIcon(
//                       Icons.location_pin, Colors.teal, "Locations", () {}),
//                   const SizedBox(width: 30),
//                   createIcon(
//                       Icons.insert_photo, Colors.blue, "Contacts", () {}),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget createIcon(IconData icon, Color color, String text, Function() ontap) {
//     return InkWell(
//       onTap: ontap,
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: color,
//             child: Icon(
//               icon,
//               size: 29,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             text,
//             style: const TextStyle(fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Widget emojiSelected(TextEditingController myController) {
// //   return EmojiPicker(
// //     config: const Config(columns: 7, backspaceColor: Colors.blueGrey),
// //     onEmojiSelected: (emoji, category) {
// //       print(emoji);
// //       setState(() {
// //         mycontroller.text = mycontroller.text + emoji.emoji!;
// //       });
// //     },
// //   );
// // }
