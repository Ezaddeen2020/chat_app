import 'package:chat_application/controller/auth/verifycode_controller.dart';
import 'package:chat_application/core/classes/status_request.dart';
import 'package:chat_application/core/constant/colors.dart';
import 'package:chat_application/view/widgets/auth/custom_bottom_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_text_body_auth.dart';
import 'package:chat_application/view/widgets/auth/custom_text_title_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifycodeSignup extends GetView<VerifyCodeSignUpControllerImp> {
  const VerifycodeSignup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeSignUpControllerImp());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          "Verification Code",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.grey),
        ),
      ),
      body: GetBuilder<VerifyCodeSignUpControllerImp>(
        builder: (controller) => controller.statusRequest == StatusRequest.loading
            ? const LinearProgressIndicator()
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    const CustomTextTitleAuth(text: "Check Email"),
                    const SizedBox(height: 10),
                    const CustomTextBodyAuth(
                      textbody: 'Please enter the 5-digit code sent to your email',
                    ),
                    const SizedBox(height: 15),
                    PinCodeTextField(
                      appContext: context,
                      length: 5, // عدد الخانات
                      onChanged: (value) {
                        // يمكنك إضافة أي منطق هنا عند تغيير القيمة
                      },
                      onCompleted: (verificationCode) {
                        controller.goToSuccessSignUp(verificationCode);
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 60,
                        fieldWidth: 40,
                        inactiveColor: Colors.grey,
                        activeColor: Colors.blue,
                        selectedColor: Colors.blueAccent,
                      ),
                      keyboardType: TextInputType.number,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    CustomButtonAuth(
                      text: "Resend Code",
                      onPressed: controller.isButtonDisabled
                          ? null // تعطيل الزر إذا كان المؤقت نشطًا
                          : () {
                              controller.resendCode();
                            },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
