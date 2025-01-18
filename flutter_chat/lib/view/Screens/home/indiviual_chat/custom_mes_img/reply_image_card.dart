// import 'dart:io';

// import 'package:flutter/material.dart';

// class ReplyImageCard extends StatelessWidget {
//   const ReplyImageCard({super.key, required this.path});
//   final String path;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//         child: Container(
//           height: MediaQuery.of(context).size.height / 2.4,
//           width: MediaQuery.of(context).size.width / 1.8,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.grey[400],
//           ),
//           child:  Card(
//             margin: const EdgeInsets.all(5),
//             child: Image.file(File(path)),
//           ),
//         ),
//       ),
//     );
//   }
// }
