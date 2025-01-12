import 'dart:async';
import 'dart:developer';

import 'package:chat_application/controller/auth/login_controller.dart';
import 'package:chat_application/core/classes/status_request.dart';
import 'package:chat_application/core/constant/routes.dart';
import 'package:chat_application/core/functions/handling_data.dart';
import 'package:chat_application/data/datasource/remote/auth/checkemail_data.dart';
import 'package:chat_application/data/datasource/remote/auth/verifycode_data.dart';
import 'package:get/get.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  // Future<void> checkCode();
  Future<void> goToSuccessSignUp(String code);
  void goToNextPage();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  //=======  Parameters of verify Code   =========//
  final LoginControllerImp loginController = Get.put(LoginControllerImp());
  CheckEmailData checkEmailData = CheckEmailData(Get.find());
  VerifycodeData verifycodeData = VerifycodeData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  bool isButtonDisabled = false; // حالة زر إعادة الإرسال
  // late String username;
  late String email;
  String? password;
  late String idotp;
  late String page;

  //======  initial page  ======//
  @override
  void onInit() {
    email = Get.arguments['email'];
    // username = Get.arguments['user_name'];
    password = Get.arguments['password'];
    idotp = Get.arguments['id_otp'];
    page = Get.arguments['page'];
    super.onInit();
  }

  //=========== Resend Code  ===========//
  void resendCode() async {
    if (!isButtonDisabled) {
      isButtonDisabled = true;
      update(); // تحديث حالة الزر في الواجهة

      // استدعاء API لإعادة إرسال الكود
      statusRequest = StatusRequest.loading;
      update();
      var response = await checkEmailData.postdata(email);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        Get.snackbar("Success", "Code resent successfully");
      } else {
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to resend the code. Try again.",
        );
      }

      Timer(const Duration(seconds: 20), () {
        isButtonDisabled = false;
        update();
      });
    }
  }

  //=========== Check Verify Code  ===========//
  @override
  Future<void> goToSuccessSignUp(String code) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await verifycodeData.postCode(code, idotp);
    log("Controller Response: $response");
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        goToNextPage();
      } else {
        Get.defaultDialog(
          title: "Warning",
          middleText: response['message'] ?? "Verification code is not correct",
        );
        statusRequest = StatusRequest.failure;
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "An unexpected error occurred. Please try again.",
      );
    }
    update();
  }

  //=========== Check
  @override
  void goToNextPage() {
    log("======================================================$page");
    if (page == 'forgetPassword') {
      Get.offNamed(AppRoute.resetPassword,
          arguments: {"email": email, "id_otp": idotp, "page": "emailverifycode"});
    } else if (page == "signup" || page == 'login') {
      // loginController.username = username;
      loginController.email.text = email;
      loginController.password.text = password ?? "";
      // print(loginController.email.text);
      // print(loginController.password.text);

      loginController.loginFromSignup();
    } else {
      Get.offNamed(AppRoute.successSignUp);
    }
  }
}