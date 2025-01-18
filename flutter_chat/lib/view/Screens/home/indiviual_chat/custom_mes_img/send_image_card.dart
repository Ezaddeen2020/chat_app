// import 'dart:io';
// import 'package:flutter/material.dart';

// enum ChatBubbleDirection {
//   sender,
//   receiver,
// }

// class SendImageCard extends StatelessWidget {
//   const SendImageCard({
//     required this.path,
//     required this.message,
//     required this.time,
//     required this.direction,
//   });

//   final String path;
//   final String message;
//   final String time;
//   final ChatBubbleDirection direction;

//   @override
//   Widget build(BuildContext context) {
//     final isSender = direction == ChatBubbleDirection.sender;

//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.6,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: const Radius.circular(15),
//               topRight: const Radius.circular(15),
//               bottomLeft: const Radius.circular(15),
//               bottomRight: isSender
//                   ? Radius.zero
//                   : const Radius.circular(
//                       25), // Sharp corner only on the sender's side
//             ),
//             color: isSender ? Colors.blueGrey : Colors.grey[300],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.file(
//                   File(path),
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: MediaQuery.of(context).size.height / 3,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   message,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: isSender ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     time,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const Icon(
//                     Icons.done_all,
//                     size: 20,
//                     color: Colors.blue,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
