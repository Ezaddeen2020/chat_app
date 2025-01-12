import 'package:flutter/material.dart';

class CustomTextformAuth extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData icon;
  final TextEditingController? myController;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obsecureText;
  final void Function()? onTapIcon;
  const CustomTextformAuth(
      {super.key,
      this.obsecureText,
      this.onTapIcon,
      required this.hintText,
      required this.label,
      required this.icon,
      required this.myController,
      required this.valid,
      required this.isNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        obscureText: //
            obsecureText == null || obsecureText == false ? false : true,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: myController, //
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          label: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(label),//
          ),
          hintText: hintText,//
          hintStyle: const TextStyle(fontSize: 14),
          suffixIcon: InkWell(
            onTap: onTapIcon,//
            child: Icon(icon),//
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
