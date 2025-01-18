import 'package:chatapp/controller/auth/signup_controller.dart';
import 'package:chatapp/core/constant/colors.dart';
import 'package:chatapp/core/functions/valid_input.dart';
import 'package:chatapp/view/widgets/auth/custom_bottom_auth.dart';
import 'package:chatapp/view/widgets/auth/custom_text_title_auth.dart';
import 'package:chatapp/view/widgets/auth/custom_textform_auth.dart';
import 'package:chatapp/view/widgets/auth/text_sign_up.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(SignUpControllerImp());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          "Sign up",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.grey),
        ),
      ),
      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Form(
            key: controller.signupFormKey,
            child: ListView(
              children: [
                const CustomTextTitleAuth(text: "Welcome Back"),
                const SizedBox(height: 20),

                //=============  Image picker  ============//
                GestureDetector(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[400],
                    child: ClipOval(
                      child: controller.userImage != null
                          ? Image.file(
                              controller.userImage!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )
                          : const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //=========== Username input =============//
                CustomTextformAuth(
                  isNumber: false,
                  valid: (val) {
                    return validInput(val!, 5, 30, "username");
                  },
                  myController: controller.username,
                  hintText: "Enter Your UserName",
                  label: "UserName",
                  icon: Icons.person,
                ),

                //==========  Email input  ===========//
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

                //==========  Phone input  ===========//
                CustomTextformAuth(
                  isNumber: true,
                  valid: (val) {
                    return validInput(val!, 9, 20, "phone");
                  },
                  myController: controller.phone,
                  hintText: "Enter Your Phone ",
                  label: "Phone Number",
                  icon: Icons.phone,
                ),

                //===========  Password input  ===========//
                CustomTextformAuth(
                  isNumber: false,
                  valid: (val) {
                    return validInput(val!, 5, 30, "password");
                  },
                  myController: controller.password,
                  hintText: "Enter Your Password",
                  label: "Password",
                  icon: Icons.lock_outlined,
                ),
                const SizedBox(height: 30),

                //===========  Sign up button  ===========//
                CustomButtonAuth(
                  text: "Sign Up",
                  onPressed: () {
                    controller.signUp();
                  },
                ),
                const SizedBox(height: 30),

                //=======  Redirect to sign in  ========//
                TextLink(
                  textOne: "Have an account? ",
                  textTwo: "Sign In",
                  onTap: () {
                    controller.goToSignIn();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
