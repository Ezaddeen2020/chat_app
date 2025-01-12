import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chat_application/view/Screens/camera/camera_screen.dart';
import 'package:chat_application/view/Screens/camera/camera_view_screen.dart';

// Main Attachment Bottom Sheet
class AttachmentBottomSheet extends StatelessWidget {
  AttachmentBottomSheet({super.key});

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: Get.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              _buildRow([
                _createIcon(Icons.insert_drive_file, Colors.indigo, "Document", () {}),
                _createIcon(Icons.camera_alt, Colors.pink, "Camera", () {
                  Get.to(() => CameraScreen());
                }),
                _createIcon(Icons.insert_photo, Colors.purple, "Gallery", () async {
                  final file = await picker.pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    Get.to(() => CameraView(imagePath: file.path));
                  }
                }),
              ]),
              const SizedBox(height: 20),
              _buildRow([
                _createIcon(Icons.headset, Colors.orange, "Audio", () {}),
                _createIcon(Icons.location_pin, Colors.teal, "Locations", () {}),
                _createIcon(Icons.insert_photo, Colors.blue, "Contacts", () {}),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<Widget> icons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons,
    );
  }

  Widget _createIcon(IconData icon, Color color, String text, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, size: 29, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
