import 'dart:developer';

import 'package:chat_application/controller/auth/login_controller.dart';
import 'package:chat_application/core/classes/status_request.dart';
import 'package:chat_application/core/functions/handling_data.dart';
import 'package:chat_application/data/datasource/remote/auth/resetpassword_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  goToSuccessResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  late TextEditingController password;
  late TextEditingController repassword;
  String? email;
  late String idotp;
  StatusRequest statusRequest = StatusRequest.none;
  late ResetpasswordData resetpasswordData = ResetpasswordData(Get.find());
  final LoginControllerImp loginController = Get.find();
  late String page;
  @override
  void onInit() {
    email = Get.arguments['email'];
    idotp = Get.arguments['id_otp'];
    page = Get.arguments['page'];
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  void goToLoginFromReset() {
    if (page == "emailverifycode") {
      // إعداد بيانات تسجيل الدخول من صفحة تغيير كلمة المرور
      loginController.email.text = email!;
      loginController.password.text = password.text; // إعادة تعيين كلمة المرور هنا
      loginController.loginFromSignup(); // استدعاء دالة تسجيل الدخول
    }
  }

  @override
  goToSuccessResetPassword() async {
    if (password.text != repassword.text) {
      Get.defaultDialog(middleText: "Warning", title: "Password Not Match");
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response = await resetpasswordData.postdata(email!, password.text, idotp);
    log("=========================$response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        goToLoginFromReset();
      } else {
        Get.defaultDialog(title: "Warning", middleText: "Try again");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }

  void goToLogin() {}
}
