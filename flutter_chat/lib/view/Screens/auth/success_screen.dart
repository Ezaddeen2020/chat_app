import 'package:chat_application/controller/auth/success_controller.dart';
import 'package:chat_application/core/constant/colors.dart';
import 'package:chat_application/view/widgets/auth/custom_bottom_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSignupScreen extends GetView<SuccessSignUpControllerImp> {
  const SuccessSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SuccessSignUpControllerImp controller =
    Get.put(SuccessSignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          "Success",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.grey),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Center(
              child: Icon(
                Icons.check_circle_outline,
                size: 200,
                color: Colors.green,
              ),
            ),
            const Text(
              "Congratulations",
              style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Success register",
            ),
            // const Text("done"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButtonAuth(
                text: "Go to chating",
                onPressed: () {
                  controller.goTochatLogin();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
