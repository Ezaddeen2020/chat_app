// import 'package:chatapp/model/chatmodel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key, required this.icon, required this.name});

  // final ChatModel contact;
  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          radius: 23,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
