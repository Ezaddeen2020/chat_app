import 'package:chatapp/controller/home_controller.dart';
import 'package:chatapp/core/classes/status_request.dart';
import 'package:chatapp/view/Screens/camera/camera_screen.dart';
import 'package:chatapp/view/Screens/home/tab_bar_screens/contacts_page.dart';
import 'package:chatapp/view/Screens/home/tab_bar_screens/home_page.dart';
import 'package:chatapp/view/Screens/home/tab_bar_screens/profiel_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeTest extends GetView<HomeController> {
  const HomeTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return controller.statusRequest == StatusRequest.loading
              ? const Center(child: Text("loading..."))
              : PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) => controller.onPageChanged(index),
                  children: [
                    CameraScreen(),
                    HomePage(),
                    const ProfilePage(),
                    ContactPage(),
                  ],
                );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return CurvedNavigationBar(
            backgroundColor: Colors.blueGrey,
            buttonBackgroundColor: Colors.white,
            color: Colors.white,
            height: 65,
            items: const <Widget>[
              Icon(Icons.camera_alt, size: 35, color: Color.fromARGB(255, 1, 5, 45)),
              Icon(Icons.chat, size: 35, color: Color.fromARGB(255, 1, 5, 45)),
              Icon(Icons.track_changes_sharp, size: 35, color: Color.fromARGB(255, 1, 5, 45)),
              Icon(Icons.phone, size: 35, color: Color.fromARGB(255, 1, 5, 45)),
            ],
            onTap: (index) {
              controller.onPageChanged(index);
              controller.pageController.jumpToPage(index);
            },
            index: controller.pageIndex.value,
          );
        },
      ),
    );
  }
}
