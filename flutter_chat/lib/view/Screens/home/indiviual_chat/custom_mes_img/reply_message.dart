// import 'package:flutter/material.dart';

// class ReplyMessage extends StatelessWidget {
//   const ReplyMessage({super.key, required this.replymessage, required this.time});
//   final String replymessage;
//   final String time;
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(constraints: BoxConstraints(
//       maxWidth: MediaQuery.of(context).size.width,
//     ),
//     child: Align(
//       alignment: Alignment.centerLeft,
//       child: Card(
//           margin: const EdgeInsets.only(right: 10, top: 10),
//           child: Stack(
//             children: [
//                Padding(
//                   padding:
//                       const EdgeInsets.only(top: 10, right: 75, left: 10, bottom: 30),
//                   child: Text(
//                     replymessage,
//                     style: const TextStyle(fontSize: 16),
//                   )),
//               Positioned(
//                 bottom: 4,
//                 right: 10,
//                 child: Text(
//                   time,
//                   style: TextStyle(fontSize: 13, color: Colors.grey[600]),
//                 ),
//               )
//             ],
//           )

//           // ),
//           ),
//       ),
//     );
//   }

// }
