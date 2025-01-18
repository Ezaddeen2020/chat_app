import 'package:chatapp/controller/screens/message_conttoller.dart';
import 'package:chatapp/view/widgets/onboarding/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:mc_utils/mc_utils.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit or Reply Container
        GetBuilder<MessageController>(
          builder: (controller) {
            var model = controller.msgModel;
            if (model != null) {
              return McCardItem(
                width: double.infinity,
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                radius: BorderRadius.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      controller.isEdit ? Icons.edit : Icons.reply,
                      color: controller.isEdit ? Colors.blue : Colors.green,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.isEdit
                                ? "Edit Message"
                                : model.senderId == controller.userModel!.userId
                                    ? "Replying to: ${controller.userModel?.userName}"
                                    : controller.userController.userModel!.userName,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            model.message?.msg ?? '',
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.red),
                      onPressed: controller.hideContainer,
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),

        const SizedBox(height: 1),

        // Input and Emoji Picker
        GetBuilder<MessageController>(
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions_outlined),
                        onPressed: () {
                          controller.toggleEmojiPicker();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: controller.focusNode,
                          controller: controller.myController,
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            controller.sendButton.value = value.trim().isNotEmpty;
                          },
                        ),
                      ),
                      Obx(() {
                        return IconButton(
                          icon: Icon(
                            controller.sendButton.value ? Icons.send : Icons.mic,
                            color: Colors.blue,
                          ),
                          onPressed: controller.sendButton.value
                              ? () {
                                  if (controller.isEdit) {
                                    controller.editMessage(controller.myController.text);
                                  } else if (controller.isReplay) {
                                    controller.sendReply(
                                        controller.myController.text, controller.msgModel!.msgKey);
                                  } else {
                                    controller.addMsg(controller.myController.text);
                                  }
                                  // co.clear();
                                }
                              : null,
                        );
                      }),
                    ],
                  ),
                  Obx(() {
                    if (controller.showEmojiPicker.value) {
                      return EmojiPickerWidget(
                        myController: controller.myController,
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
