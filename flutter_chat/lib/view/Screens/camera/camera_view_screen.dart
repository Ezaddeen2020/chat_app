import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';

// ignore: must_be_immutable
class CameraView extends StatelessWidget {
  CameraView({super.key, this.imagePath, this.onImageSend});

  final String? imagePath;
  late Function? onImageSend;
  static TextEditingController control = TextEditingController();

  Color prefixIconColor = Colors.grey;

  void handleTap() {
    prefixIconColor = Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.crop_rotate,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              size: 27,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 140,
              child: Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: TextFormField(
                  controller: control,
                  onTap: handleTap,
                  maxLines: 7,
                  minLines: 1,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Add Caption....",
                    hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                    prefixIcon: Icon(
                      Icons.add_photo_alternate,
                      color: prefixIconColor,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        onImageSend!(
                          imagePath,
                          control.text.trim(),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Icon(Icons.check),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
