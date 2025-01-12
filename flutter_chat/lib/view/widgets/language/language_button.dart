import 'package:chat_application/core/constant/colors.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, required this.textbutton, this.onPressed});

  final String textbutton;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      width: double.infinity,
      child: Column(
        children: [
          MaterialButton(
            onPressed: onPressed,
            color: AppColors.primaryColor,
            child: Text(
              textbutton,
              style:
                  const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
