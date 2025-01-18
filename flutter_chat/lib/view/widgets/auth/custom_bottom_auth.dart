import 'package:chatapp/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({super.key, required this.text, this.onPressed});
  final String text; 
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        color: AppColors.secondeColor,
        textColor: Colors.white,
        child: Text(text),
      ),
    );
  }
}
