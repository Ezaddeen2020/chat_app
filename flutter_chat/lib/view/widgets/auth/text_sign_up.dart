import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  const TextLink({super.key, required this.textOne, required this.textTwo, required this.onTap});

  final String textOne;
  final String textTwo;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(textOne),
        InkWell(
          onTap: onTap,
          child: Text(textTwo,style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
        ),
        
        ],
    );
  }
}
