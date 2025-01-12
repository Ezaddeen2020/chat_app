import 'package:chat_application/controller/auth/reset_password_controller.dart';
import 'package:chat_application/core/classes/status_request.dart';
import 'package:chat_application/core/constant/colors.dart';
import 'package:chat_application/core/functions/valid_input.dart';
import 'package:chat_application/view/widgets/auth/custom_bottom_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_text_body_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_text_title_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_textform_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordControllerImp());
    // Get.find<ResetPasswordControllerImp>();

    return WillPopScope(
        onWillPop: () async => false, // يمنع الرجوع للخلف
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false, // يخفي سهم الرجوع من AppBar
              backgroundColor: AppColors.backgroundColor,
              centerTitle: true,
              title: Text(
                "Reset Password",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.grey),
              ),
            ),
            body: GetBuilder<ResetPasswordControllerImp>(
              builder: (controller) => controller.statusRequest == StatusRequest.loading
                  ? const Center(child: Text("Loading..."))
                  : Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Form(
                        // key: controller.,
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),
                            const CustomTextTitleAuth(text: "New Password"),
                            const SizedBox(height: 10),
                            const CustomTextBodyAuth(textbody: 'please enter new password '),
                            const SizedBox(height: 40),
                            CustomTextformAuth(
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 5, 20, "password");
                              },
                              myController: controller.password,
                              hintText: "Enter new Password",
                              label: "Password",
                              icon: Icons.lock_outlined,
                              // myController: myController,
                            ),
                            CustomTextformAuth(
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 5, 20, "password");
                              },
                              myController: controller.repassword,
                              hintText: "Repeate new Password",
                              label: "Password",
                              icon: Icons.lock_outlined,
                              // myController: myController,
                            ),
                            CustomButtonAuth(
                              text: "Save",
                              onPressed: () {
                                controller.goToSuccessResetPassword();
                              },
                            ),
                            const SizedBox(height: 40)
                          ],
                        ),
                      ),
                    ),
            )));
  }
}
