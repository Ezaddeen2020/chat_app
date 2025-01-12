import 'package:chat_application/controller/screens/message_conttoller.dart';
import 'package:chat_application/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:mc_utils/mc_utils.dart';

class MessageItem extends StatelessWidget {
  final ChatModel message;
  final MessageController controller = Get.find<MessageController>();
  final int index;

  MessageItem({
    super.key,
    required this.message,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var isSender = message.senderId == controller.userController.userModel?.userId;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: IntrinsicWidth(
        child: buildMessage(context, message, isSender),
      ),
    );
  }

  Widget buildMessage(BuildContext context, ChatModel message, bool isSender) {
    String formattedTime = DateFormat("hh:mm a").format(message.timestamp.toLocal());

    return GestureDetector(
      onLongPress: () {
        controller.isSelected.value = true;
        controller.toggleSelectMsg(index);
      },
      onTap: () {
        if (controller.isSelected.value) {
          controller.toggleSelectMsg(index);
        } else {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              MediaQuery.of(context).size.width / 3,
              MediaQuery.of(context).size.height / 2,
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2,
            ),
            items: [
              const PopupMenuItem(
                value: "Reply",
                child: Row(
                  children: [
                    Icon(Icons.replay),
                    SizedBox(width: 10),
                    Text("Reply"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "Copy",
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 10),
                    Text("Copy"),
                  ],
                ),
              ),
              if (isSender)
                const PopupMenuItem(
                  value: "Edit",
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      Text("Edit"),
                    ],
                  ),
                ),
              if (isSender)
                const PopupMenuItem(
                  value: "Delete",
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 10),
                      Text("Delete"),
                    ],
                  ),
                ),
            ],
          ).then((value) {
            if (value != null) {
              switch (value) {
                case "Reply":
                  controller.replayToMsg(message);
                  break;
                case "Copy":
                  controller.copyMessage(message.message?.msg ?? "No message", context);
                  break;
                case "Edit":
                  controller.showEditContainer(message);
                  break;
                case "Delete":
                  showAlertMsg(context, message);
                  break;
              }
            }
          });
        }
      },
      child: Obx(() {
        bool isSelect = controller.selectedIndex.contains(index);
        var replay = message.message?.replayMsg;
        var model = controller.getModelReplay(replay);

        return Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelect
                ? Colors.blue.withOpacity(0.3)
                : (isSender ? const Color.fromARGB(255, 4, 57, 142) : Colors.grey[300]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model != null) ...[
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                  ),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSender ? Colors.blue[50] : Colors.blue[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.senderId == controller.userModel?.userId
                            ? controller.userModel!.userName
                            : controller.userController.userModel!.userName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.message!.msg,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Text(
                message.message?.msg.isNotEmpty == true ? message.message!.msg : "No message",
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelect) const Icon(Icons.check_circle, color: Colors.green),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(
                            fontSize: 10,
                            color: isSender ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (isSender)
                          Icon(
                            message.msgView
                                ? Icons.done_all
                                : message.msgSent
                                    ? Icons.done
                                    : Icons.access_time,
                            size: 16,
                            color: isSender ? Colors.white70 : Colors.black54,
                          ),
                        if (message.message?.editMsgbyKey ?? false)
                          const Text(
                            "edited",
                            style: TextStyle(color: Colors.grey),
                          ),
                        if (message.message?.delMsgbykey ?? false)
                          const Icon(
                            Icons.block,
                            size: 16,
                            color: Colors.grey,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void showAlertMsg(BuildContext context, ChatModel message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Message"),
          content: const Text("Are you sure you want to delete this message?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                message.msgKey.isNotEmpty ? message.msgKey : "default_key";
                controller.delMsgFun(message);
                Get.back();
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}










// import 'dart:developer';

// import 'package:chat_application/controller/screens/message_conttoller.dart';
// import 'package:chat_application/data/models/chat_model.dart';
// import 'package:flutter/material.dart';
// import 'package:mc_utils/mc_utils.dart';

// class MessageItem extends StatelessWidget {
//   final ChatModel message;
//   final MessageController controller = Get.find<MessageController>();
//   final int index;

//   MessageItem({
//     super.key,
//     required this.message,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var isSender = message.senderId == controller.userController.userModel?.userId;

//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: IntrinsicWidth(
//         child: buildMessage(context, message, isSender),
//       ),
//     );
//   }

//   Widget buildMessage(BuildContext context, ChatModel message, bool isSender) {
//     String formattedTime = DateFormat("hh:mm a").format(message.timestamp.toLocal());

//     return GestureDetector(
//       onLongPress: () {
//         controller.isSelected.value = true;
//         controller.toggleSelectMsg(index);
//       },
//       onTap: () {
//         if (controller.isSelected.value) {
//           controller.toggleSelectMsg(index);
//         } else {
//           showMenu(
//             context: context,
//             position: RelativeRect.fromLTRB(
//               MediaQuery.of(context).size.width / 3,
//               MediaQuery.of(context).size.height / 2,
//               MediaQuery.of(context).size.width / 2,
//               MediaQuery.of(context).size.height / 2,
//             ),
//             items: [
//               const PopupMenuItem(
//                 value: "Reply",
//                 child: Row(
//                   children: [
//                     Icon(Icons.replay),
//                     SizedBox(width: 10),
//                     Text("Reply"),
//                   ],
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: "Copy",
//                 child: Row(
//                   children: [
//                     Icon(Icons.copy),
//                     SizedBox(width: 10),
//                     Text("Copy"),
//                   ],
//                 ),
//               ),
//               if (isSender)
//                 const PopupMenuItem(
//                   value: "Edit",
//                   child: Row(
//                     children: [
//                       Icon(Icons.edit),
//                       SizedBox(width: 10),
//                       Text("Edit"),
//                     ],
//                   ),
//                 ),
//               if (isSender)
//                 const PopupMenuItem(
//                   value: "Delete",
//                   child: Row(
//                     children: [
//                       Icon(Icons.delete, color: Colors.red),
//                       SizedBox(width: 10),
//                       Text("Delete"),
//                     ],
//                   ),
//                 ),
//             ],
//           ).then((value) {
//             if (value != null) {
//               switch (value) {
//                 case "Reply":
//                   controller.replayToMsg(message);
//                   break;
//                 case "Copy":
//                   controller.copyMessage(message.message?.msg ?? "No message", context);
//                   break;
//                 case "Edit":
//                   controller.showEditContainer(message);
//                   break;
//                 case "Delete":
//                   showAlertMsg(context, message);
//                   break;
//               }
//             }
//           });
//         }
//       },
//       child: Obx(() {
//         bool isSelect = controller.selectedIndex.contains(index);
//         var replay = message.message?.replayMsg;
//         var model = controller.getModelReplay(replay);

//         return Container(
//           constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           decoration: BoxDecoration(
//             color: isSelect
//                 ? Colors.blue.withOpacity(0.3)
//                 : (isSender ? const Color.fromARGB(255, 4, 57, 142) : Colors.grey[300]),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (model != null) ...[
//                 Container(
//                   constraints: BoxConstraints(
//                     maxWidth: MediaQuery.of(context).size.width * 0.5,
//                     minWidth: MediaQuery.of(context).size.width * 0.5,
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   margin: const EdgeInsets.only(bottom: 8),
//                   decoration: BoxDecoration(
//                     color: isSender ? Colors.blue[50] : Colors.blue[300],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         model.senderId == controller.userModel?.userId
//                             ? controller.userModel!.userName
//                             : controller.userController.userModel!.userName,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         model.message!.msg,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//               Text(
//                 message.message?.msg.isNotEmpty == true ? message.message!.msg : "No message",
//                 style: TextStyle(
//                   color: isSender ? Colors.white : Colors.black,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (isSelect) const Icon(Icons.check_circle, color: Colors.green),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           formattedTime,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: isSender ? Colors.white70 : Colors.black54,
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         if (isSender)
//                           // Icon(
//                           //   message.msgView
//                           //       ? Icons.done_all
//                           //       : message.msgSent
//                           //           ? Icons.done
//                           //           : Icons.access_time,
//                           //   size: 16,
//                           //   color: message.msgView ? Colors.white70 : Colors.black54,
//                           // ),
//                           Icon(
//                             message.msgView
//                                 ? Icons.done_all
//                                 : message.msgSent
//                                     ? Icons.done
//                                     : Icons.done_all,
//                             size: 16,
//                             color: message.msgView ? Colors.blue : Colors.grey,
//                           ),
//                         if (message.message?.editMsgbyKey ?? false)
//                           const Text(
//                             "edited",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         if (message.message?.delMsgbykey ?? false)
//                           const Icon(
//                             Icons.block,
//                             size: 16,
//                             color: Colors.grey,
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   void showAlertMsg(BuildContext context, ChatModel message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Delete Message"),
//           content: const Text("Are you sure you want to delete this message?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 message.msgKey.isNotEmpty ? message.msgKey : "default_key";
//                 controller.delMsgFun(message);
//                 Get.back();
//               },
//               child: const Text("Delete", style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
