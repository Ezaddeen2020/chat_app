// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class OtherStatus extends StatelessWidget {
  const OtherStatus(
      {super.key,
      required this.imagename,
      required this.name,
      required this.time,
      required this.isSeen,
      required this.statusNum});
  final String imagename;
  final String name;
  final String time;
  final bool isSeen;
  final int statusNum;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(
          isSeen: isSeen,
          statusNum: statusNum,
        ),
        child: CircleAvatar(
          radius: 26,
          backgroundImage: AssetImage(imagename),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text("Today at $time"),
    );
  }
}

degreeToAngle(double degree) {
  return degree * pi / 180;
}

class StatusPainter extends CustomPainter {
  bool isSeen;
  int statusNum;
  StatusPainter({
    required this.isSeen,
    required this.statusNum,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..color = isSeen ? Colors.grey : const Color(0xff21bfa6)
      ..style = PaintingStyle.stroke;

    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if (statusNum == 1) {
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        degreeToAngle(0),
        degreeToAngle(360),
        false,
        paint,
      );
    } else {
      double degree = -90;
      double arc = 360 / statusNum;
      for (int i = 0; i < statusNum; i++) {
        canvas.drawArc(
          Rect.fromLTWH(0, 0, size.width, size.height),
          degreeToAngle(degree + 4),
          degreeToAngle(arc - 8),
          false,
          paint,
        );
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
















// import 'dart:math';

// import 'package:flutter/material.dart';

// class OtherStatus extends StatelessWidget {
//   const OtherStatus({
//     Key? key,
//     required this.imagename,
//     required this.name,
//     required this.time,
//   }) : super(key: key);

//   final String imagename;
//   final String name;
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Container(
//         width: 52,
//         height: 52,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             width: 0.5,
//             color: Color(0xff21bfa6),
//           ),
//         ),
//         child: CircleAvatar(
//           radius: 26,
//           backgroundImage: AssetImage(imagename),
//         ),
//       ),
//       title: Text(
//         name,
//         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//       ),
//       subtitle: Text("Today at $time"),
//     );
//   }
// }
