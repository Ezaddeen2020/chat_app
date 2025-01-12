import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyStatus extends StatelessWidget {
  const MyStatus({super.key , this.userImage,this.userName});
  final String? userImage;  
  final String? userName;  

  @override
  Widget build(BuildContext context) {
        final String? userImage = Get.arguments?['user_img'];  
        // final String? userName = Get.arguments?['user_'];  
    return ListTile(
      leading: Stack( 
        children: [
           CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: userImage != null 
            ? FileImage(File(userImage))
            : const AssetImage("assets/images/photo.JPG") as ImageProvider,
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent[700],
              radius: 10,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      title: const Text(
        // userName != null ? userName: const Text("my status"),
        "My Status",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "Tab to add status update",
        style: TextStyle(color: Colors.grey[900], fontSize: 12),
      ),
    );
  }
}
