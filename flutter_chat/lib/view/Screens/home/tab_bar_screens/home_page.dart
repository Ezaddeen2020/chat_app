import 'package:chatapp/core/constant/routes.dart';
import 'package:chatapp/view/Screens/home/menu_screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatapp/controller/home_controller.dart';
import 'package:chatapp/view/Screens/home/conversation_list.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

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
          return const Text('ChatApp');
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
                        onTap: controller.userController.logout,
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
