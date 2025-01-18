import 'package:chatapp/core/classes/status_request.dart';
import 'package:chatapp/core/constant/routes.dart';
import 'package:chatapp/core/functions/handling_data.dart';
import 'package:chatapp/data/datasource/remote/auth/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetpasswordControllerImp extends GetxController {
  AuthData checkEmailData = AuthData(Get.find());
  final forgetPasswordFormKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  var email = TextEditingController();
  var isLoading = false.obs;

  checkEmailFunc() async {
    if (forgetPasswordFormKey.currentState!.validate() && !isLoading.value) {
      isLoading.value = true;
      statusRequest = StatusRequest.loading;

      var response = await checkEmailData.checkEmailFun(email.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success && response['status'] == "success") {
        Get.offNamed(AppRoute.emailVerifyCode, arguments: {
          "email": email.text,
          "id_otp": response['id_otp'],
          "page": "forgetPassword",
        });
      } else {
        Get.defaultDialog(title: "Warning", middleText: "Email Not Found");
      }
      isLoading.value = false;
    }
  }
}
