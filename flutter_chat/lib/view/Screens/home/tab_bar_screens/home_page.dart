import 'package:chat_application/controller/screens/message_conttoller.dart';
import 'package:chat_application/core/constant/routes.dart';
import 'package:chat_application/data/models/preferences.dart';
import 'package:chat_application/view/Screens/auth/login_screen.dart';
import 'package:chat_application/view/Screens/home/menu_screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_application/controller/home_controller.dart';
import 'package:chat_application/view/Screens/home/conversation_list.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final MessageController msgController = MessageController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[700],
        onPressed: () async {
          Get.toNamed(AppRoute.selectContacts);
        },
        child: const Icon(Icons.library_add),
      ),
      appBar: AppBar(
        title: Obx(() {
          if (controller.isSelected.value) {
            return Text('${controller.selectedIndex.length} تم تحديد ');
          }
          return const Text('chat_application');
        }),
        leading: Obx(() {
          if (controller.isSelected.value) {
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: controller.cancelSelect,
            );
          }
          return const SizedBox.shrink();
        }),
        actions: [
          Obx(() {
            if (controller.isSelected.value) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.select_all),
                    onPressed: controller.toggleSelectAll,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: controller.deleteSelected,
                  ),
                ],
              );
            }
            return Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Search func
                  },
                ),
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: "New group",
                        child: Text("New group"),
                      ),
                      const PopupMenuItem(
                        value: "New broadcast",
                        child: Text("New broadcast"),
                      ),
                      const PopupMenuItem(
                        value: "WhatsApp Web",
                        child: Text("WhatsApp Web"),
                      ),
                      const PopupMenuItem(
                        value: "Shared message",
                        child: Text("Shared message"),
                      ),
                      PopupMenuItem(
                        value: "Setting",
                        onTap: () async {
                          await Get.offAll(() => const SettingsScreen());
                        },
                        child: const Text('Setting'),
                      ),
                      PopupMenuItem(
                        value: "Logout",
                        onTap: () async {
                          await Preferences.clearSharPreference();
                          Get.offAll(() => const LoginScreen());
                        },
                        child: const Text("Logout"),
                      ),
                    ];
                  },
                ),
              ],
            );
          }),
        ],
      ),
      body: Obx(() {
        var chatData = controller.chatUserslist;
        return Column(
          children: [
            if (chatData.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'لا توجد دردشة حالياً',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (chatData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatData.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 16),
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ConversationList(
                      chatUser: chatData[index],
                      index: index,
                    );
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
