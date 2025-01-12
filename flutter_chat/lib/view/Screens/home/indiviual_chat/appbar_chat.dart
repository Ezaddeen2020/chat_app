import 'package:chat_application/controller/screens/message_conttoller.dart';
import 'package:flutter/material.dart';
import 'package:mc_utils/mc_utils.dart';

class chat_applicationBar extends StatelessWidget implements PreferredSizeWidget {
  const chat_applicationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageController controller = Get.put(MessageController());
    // final HomeController homeController = Get.find<HomeController>();
    final RxString formattedTime = ''.obs;

    // تحديث الوقت بشكل دوري
    Rx<DateTime> currentTime = Rx(DateTime.now());
    Stream.periodic(const Duration(seconds: 1), (_) {
      currentTime.value = DateTime.now();
    }).listen((_) {
      formattedTime.value = DateFormat('hh:mm a').format(currentTime.value);
    });

    return AppBar(
      leadingWidth: 80,
      titleSpacing: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Obx(() {
          if (controller.isSelected.value) {
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: controller.cancelSelectMsg,
            );
          }
          return const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 22),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                backgroundImage: AssetImage("assets/images/photo.JPG"),
              ),
            ],
          );
        }),
      ),
      title: Obx(
        () {
          if (controller.isSelected.value) {
            return Text('${controller.selectedIndex.length} تم تحديد ');
          }
          return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.userModel?.userName ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.5, color: Colors.black),
                ),
                Obx(() => Text(
                      formattedTime.value,
                      style: const TextStyle(fontSize: 13.5),
                    )),
              ],
            ),
          );
        },
      ),
      actions: [
        Obx(() {
          if (controller.isSelected.value) {
            return Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.check_box, color: Colors.green),
                  onPressed: controller.toggleSelectAllMsg,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: controller.deleteSelectedMsg,
                ),
              ],
            );
          }

          return Row(children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    value: "View Contact",
                    child: Text("View Contact"),
                  ),
                  PopupMenuItem(
                    value: "Media, Links, and docs",
                    child: Text("Media, Links, and docs"),
                  ),
                  PopupMenuItem(
                    value: "WhatsApp Web",
                    child: Text("WhatsApp Web"),
                  ),
                  PopupMenuItem(
                    value: "Search",
                    child: Text("Search"),
                  ),
                  PopupMenuItem(
                    value: "Mute Notification",
                    child: Text("Mute Notification"),
                  ),
                  PopupMenuItem(
                    value: "Wallpaper",
                    child: Text("Wallpaper"),
                  ),
                ];
              },
            ),
          ]);
        })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
