import 'package:chat_application/view/Screens/home/tab_bar_screens/custom_appbar.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Camer page",
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.grey),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_outlined,
                size: 120,
                color: Colors.white,
              ),
              Text(
                'Camera Page',
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ));
  }
}
