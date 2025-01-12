// // import 'package:chat_application/Contacts/contacts_card.dart';
// import 'package:chat_application/view/widgets/Contacts/contacts_card.dart';
// import 'package:chat_application/view/widgets/onboarding/avatar_card.dart';
// // import 'package:chat_application/custom_Ui/button_card.dart';
// import 'package:chat_application/data/models/chatmodel.dart';
// import 'package:flutter/material.dart';

// class CreateGroup extends StatefulWidget {
//   const CreateGroup({super.key});

//   @override
//   State<CreateGroup> createState() => _CreateGroupState();
// }

// class _CreateGroupState extends State<CreateGroup> {
//   List<ChatModel> contacts = [
//     ChatModel(name: "Ezaddeen ", status: "The life is harder than you think"),
//     ChatModel(name: "Salem salem", status: "The life is harder than "),
//     ChatModel(name: "Saddam naji", status: "The life is harde"),
//     ChatModel(name: "Salma abdo", status: "Love you Mom"),
//     ChatModel(name: "Ahmed abdo", status: "The life is "),
//     ChatModel(name: "Nader abdo", status: "The life is "),
//     ChatModel(name: "Younis abdo", status: "The life is "),
//     ChatModel(name: "Fatema ", status: "The life is "),
//     ChatModel(name: "Saged ", status: "The life is "),
//     ChatModel(name: "Badr ", status: "The life is "),
//     ChatModel(name: "Mohammed ", status: "The life is "),
//   ];

//   List<ChatModel> groupsMembers = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "New Group",
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "Add New Members",
//               style: TextStyle(color: Colors.white, fontSize: 12),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.search),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           ListView.builder(
//             itemCount: contacts.length + 1,
//             itemBuilder: (context, index) {
//               if (index == 0) {
//                 return Container(
//                   height: groupsMembers.isNotEmpty ? 90 : 0,
//                 );
//               }
//               return InkWell(
//                 onTap: () {
//                   if (contacts[index - 1].select == false) {
//                     setState(
//                       () {
//                         contacts[index - 1].select = true;
//                         groupsMembers.add(contacts[index - 1]);
//                       },
//                     );
//                   } else {
//                     setState(
//                       () {
//                         contacts[index - 1].select = false;
//                         groupsMembers.remove(contacts[index - 1]);
//                       },
//                     );
//                   }
//                 },
//                 child: ContactsCard(contact: contacts[index - 1]),
//               );
//             },
//           ),
//           groupsMembers.isNotEmpty
//               ? Column(
//                   children: [
//                     Container(
//                       // padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
//                       height: 75,
//                       color: Colors.white,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: contacts.length,
//                         itemBuilder: (context, index) {
//                           if (contacts[index].select == true) {
//                             return InkWell(
//                               onTap: () {
//                                 setState(
//                                   () {
//                                     groupsMembers.remove(contacts[index]);
//                                     contacts[index].select = false;
//                                   },
//                                 );
//                               },
//                               child: AvatarCard(
//                                 contact: contacts[index],
//                               ),
//                             );
//                           } else {
//                             return Container();
//                           }
//                         },
//                       ),
//                     ),
//                     const Divider(thickness: 2)
//                   ],
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }
