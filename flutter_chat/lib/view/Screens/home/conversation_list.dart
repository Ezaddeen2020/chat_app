import 'package:chat_application/controller/home_controller.dart';
import 'package:chat_application/links_api.dart';
import 'package:flutter/material.dart';
import 'package:chat_application/data/models/chat_user_model.dart';
import 'package:mc_utils/mc_utils.dart';

class ConversationList extends StatelessWidget {
  final ChatUserModel chatUser;
  final int index;

  ConversationList({
    super.key,
    required this.chatUser,
    required this.index,
  });

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var chatModel = chatUser.chatModellist!.first;
    var isSender = chatModel.senderId == controller.userController.userModel?.userId;
    String formattedTime = '';
    if (chatUser.chatModellist!.isNotEmpty) {
      DateTime timestamp = chatModel.timestamp;
      formattedTime = DateFormat('hh:mm a').format(timestamp);
    }
    var countr = chatUser.chatModellist?.where((element) => !element.msgView && !isSender).toList();

    return GestureDetector(
      onLongPress: () {
        controller.isSelected.value = true;
        controller.toggleSelect(index);
      },
      child: Obx(() {
        bool isSelected = controller.selectedIndex.contains(index);
        return ListTile(
          leading: Stack(
            children: [
              McImageNetWork(
                height: 50,
                width: 50,
                isCircle: true,
                url: "${AppLinks.server}/files/image?name=${chatUser.user.userImg}",
                pathImgError: "assets/images/photo.JPG",
              ),
              if (chatUser.isOnline)
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.green,
                  ),
                ),
              if (countr != null && countr.isNotEmpty)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      countr.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            chatUser.user.userName,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  chatUser.chatModellist?.isNotEmpty == true &&
                          chatModel.message?.msg.trim().isNotEmpty == true
                      ? chatModel.message!.msg
                      : 'No ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isSender)
                Icon(
                  chatModel.msgView
                      ? Icons.done_all
                      : chatModel.msgSent
                          ? Icons.done
                          : Icons.access_time,
                  size: 16,
                  color: isSender ? Colors.grey : Colors.black54,
                ),
            ],
          ),
          trailing: isSelected
              ? const Icon(Icons.check_circle, color: Colors.green)
              : Text(
                  formattedTime,
                ),
          onTap: () {
            if (controller.isSelected.value) {
              controller.toggleSelect(index);
            } else {
              controller.goToIndiviual(chatUser);
            }
          },
        );
      }),
    );
  }
}
