import 'package:chatapp/controller/auth/login_controller.dart';
import 'package:chatapp/core/constant/colors.dart';
import 'package:chatapp/core/functions/valid_input.dart';
import 'package:chatapp/view/widgets/auth/custom_bottom_auth.dart';
import 'package:chatapp/view/widgets/auth/custom_text_body_auth.dart';
import 'package:chatapp/view/widgets/auth/custom_text_title_auth.dart';
import 'package:chatapp/view/widgets/auth/custom_textform_auth.dart';
import 'package:chatapp/view/widgets/auth/text_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginControllerImp> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          "2".tr,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.grey),
        ),
      ),
      body: GetBuilder<LoginControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Form(
            key: controller.loginFormKey,
            child: ListView(
              children: [
                // const LogoAuth(),
                const SizedBox(height: 10),
                const CustomTextTitleAuth(text: "Welcome back"),
                const SizedBox(height: 10),
                const CustomTextBodyAuth(
                    textbody: 'Sign in with your email and password or with social media '),
                const SizedBox(height: 15),
                CustomTextformAuth(
                  isNumber: false,
                  valid: (val) {
                    return validInput(val!, 5, 100, "email");
                  },
                  myController: controller.email,
                  hintText: "Enter Your Email",
                  label: "Email",
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 15),
                CustomTextformAuth(
                  obsecureText: controller.isShowPassword,
                  onTapIcon: controller.showPassword,
                  isNumber: false,
                  valid: (val) {
                    return validInput(val!, 5, 30, "password");
                  },
                  myController: controller.password,
                  hintText: "Enter Your Password",
                  label: "Password",
                  icon: Icons.lock_outlined,
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: controller.goToForgetPassword,
                  child: const Text(
                    "Forget Password",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomButtonAuth(
                  text: "Sign In",
                  onPressed: controller.login,
                ),
                const SizedBox(height: 20),

                // ElevatedButton(
                //   onPressed: () {
                //     controller.loginWithGoogle();
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.red, // لون الخلفية
                //     padding: const EdgeInsets.symmetric(vertical: 15),
                //   ),
                //   child: const Text(
                //     "تسجيل الدخول باستخدام جوجل",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                const SizedBox(height: 30),
                TextLink(
                  textOne: "Don't have an account?",
                  textTwo: "  Sign Up",
                  onTap: controller.goToSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
