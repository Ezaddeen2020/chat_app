// import 'package:chat_application/controller/auth/forgetpassword_controller.dart';
// import 'package:chat_application/core/classes/status_request.dart';
// import 'package:chat_application/core/constant/colors.dart';
// // import 'package:chat_application/core/localization/change_local.dart';
// import 'package:chat_application/view/widgets/auth/custom_bottom_auth.dart';
// import 'package:chat_application/view/widgets/auth/custom_text_body_auth.dart';
// import 'package:chat_application/view/widgets/auth/custom_text_title_auth.dart';
// import 'package:chat_application/view/widgets/auth/custom_textform_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ForgetPasswordScreen extends StatelessWidget {
//   const ForgetPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(ForgetpasswordControllerImp());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         centerTitle: true,
//         title: Text(
//           "Forget Password ",
//           style: Theme.of(context)
//               .textTheme
//               .displayLarge!
//               .copyWith(color: AppColors.grey),
//         ),
//       ),
//       body: GetBuilder<ForgetpasswordControllerImp>(
//         builder: (controller) => controller.statusRequest ==
//                 StatusRequest.loading
//             ? const Center(child: Text("...Loading"))
//             : Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//                 child: Form(
//                   key: controller.forgetPasswordFormKey,
//                   child: ListView(
//                     children: [
//                       const SizedBox(height: 10),
//                       const CustomTextTitleAuth(text:""),
//                       const SizedBox(height: 10),
//                       const CustomTextBodyAuth(
//                           textbody:
//                               'Please enter your email address to recive a verification code '),
//                       const SizedBox(height: 15),
//                       CustomTextformAuth(
//                         isNumber: false,
//                         valid: (val) {
//                           return null;
//                           // return validInput(val!, 5, 20, "password");
//                         },
//                         myController: controller.email,
//                         hintText: "Enter Your Email",
//                         label: "Email",
//                         icon: Icons.email_outlined,
//                         // myController: myController,
//                       ),
//                       CustomButtonAuth(
//                         text: "Check",
//                         onPressed: () {
//                           controller.checkemailFunc();
//                         },
//                       ),
//                       const SizedBox(height: 40)
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:chat_application/controller/auth/forgetpassword_controller.dart';
import 'package:chat_application/core/constant/colors.dart';
import 'package:chat_application/core/functions/valid_input.dart';
import 'package:chat_application/view/widgets/auth/custom_bottom_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_text_body_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_text_title_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_textform_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetpasswordControllerImp());

    return WillPopScope(
      onWillPop: () async => true, // يمنع الرجوع للخلف
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true, // يخفي سهم الرجوع من AppBar
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Get.back(); // Navigate back to the previous screen
            },
          ),
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: Text(
            "Forget Password",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.grey),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Form(
                    key: controller.forgetPasswordFormKey,
                    child: ListView(
                      children: [
                        const SizedBox(height: 10),
                        const CustomTextTitleAuth(text: ""),
                        const SizedBox(height: 10),
                        const CustomTextBodyAuth(
                          textbody:
                              'Please enter your email address to receive a verification code',
                        ),
                        const SizedBox(height: 15),
                        CustomTextformAuth(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 5, 100, 'email');
                          },
                          myController: controller.email,
                          hintText: "Enter Your Email",
                          label: "Email",
                          icon: Icons.email_outlined,
                        ),
                        CustomButtonAuth(
                          text: "Check",
                          onPressed: () => controller.checkEmailFunc(),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
