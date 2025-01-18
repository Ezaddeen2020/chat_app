import 'package:chatapp/view/Screens/status/my_status.dart';
import 'package:chatapp/view/Screens/status/other_status.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blueGrey[100],
            onPressed: () {},
            child: Icon(
              Icons.edit,
              color: Colors.blueGrey[900],
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            onPressed: () {},
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MyStatus(),
            label("Recent updates"),
            const SizedBox(height: 5),
            const OtherStatus(
              imagename: "assets/images/photo.JPG",
              name: "Adhm Al-Slahi",
              time: "Today at 8:15",
              isSeen: false,
              statusNum: 15,
            ),
            const OtherStatus(
              imagename: "assets/images/photo.JPG",
              name: "Adhm Al-Slahi",
              time: "Today at 12:45",
              isSeen: false,
              statusNum: 2,
            ),
            const OtherStatus(
              imagename: "assets/images/photo.JPG",
              name: "Adhm Al-Slahi",
              time: "Today at 5:00",
              isSeen: false,
              statusNum: 5,
            ),
            const OtherStatus(
              imagename: "assets/images/photo.JPG",
              name: "Adhm Al-Slahi",
              time: "Today at 9:30",
              isSeen: false,
              statusNum: 10,
            ),
            const SizedBox(height: 5),
            label("Veiwed updates"),
            const OtherStatus(
              imagename: "assets/images/itsme.JPG",
              name: "Ezadeen Al-Qubati",
              time: "Today at 1:38",
              isSeen: true,
              statusNum: 3,
            ),
            const OtherStatus(
              imagename: "assets/images/www.jpg",
              name: "Adhm Al-Slahi",
              time: "Today at 11:33",
              isSeen: true,
              statusNum: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelname) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Text(
          labelname,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
