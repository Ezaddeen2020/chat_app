import 'package:chatapp/data/models/call_model.dart';
import 'package:chatapp/view/Screens/home/tab_bar_screens/custom_camera_appbar.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  final List<CallModel> listCall = [
    CallModel("Azooz M. Thabet", "Today, 3:40 pm", "incoming", "assets/images/person.svg"),
    CallModel("Adhm W. Alslahi", "Today, 3:40 pm", "outgoing", "assets/images/person.svg"),
    CallModel("Ahmed M. Thabet", "Today, 3:40 pm", "missed", "assets/images/person.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contacts page',
      ),
      body: ListView.builder(
        itemCount: listCall.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(listCall[i].profileImage),
              radius: 26,
            ),
            title: Text(
              listCall[i].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(
                  listCall[i].callType == 'incoming'
                      ? Icons.call_received
                      : listCall[i].callType == 'outgoing'
                          ? Icons.call_made
                          : Icons.call_missed,
                  color: listCall[i].callType == 'missed' ? Colors.red : Colors.green,
                  size: 16,
                ),
                Text(listCall[i].date),
              ],
            ),
            trailing: const Icon(
              Icons.call,
              color: Colors.green,
            ),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF25D366),
        child: const Icon(
          Icons.add_call,
          color: Colors.white,
        ),
      ),
    );
  }
}
