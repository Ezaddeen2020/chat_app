// import 'package:flutter/material.dart';

// class SendMessage extends StatelessWidget {
//   const SendMessage({super.key, required this.sendmessage, required this.time});
//   final String sendmessage;
//   final String time;
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width,
//       ),
//       child: Align( 
//         alignment: Alignment.centerRight,
//         child: Card(
//           margin: const EdgeInsets.only(right: 10, top: 10),
//           color: const Color(0xffdcf8c6),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   right: 75,
//                   left: 10,
//                   bottom: 30,
//                 ),
//                 child: Text(
//                   sendmessage,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//               Positioned(
//                 bottom: 4,
//                 right: 10,
//                 child: Row(
//                   children: [
//                     Text(
//                       time,
//                       style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//                     ),
//                     const SizedBox(width: 5),
//                     const Icon(
//                       Icons.done_all,
//                       size: 20,
//                       color: Colors.blue,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
