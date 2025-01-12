import 'package:chat_application/core/classes/status_request.dart';
import 'package:chat_application/core/constant/routes.dart';
import 'package:chat_application/core/functions/handling_data.dart';
import 'package:chat_application/data/datasource/remote/auth/checkemail_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetpasswordControllerImp extends GetxController {
  late CheckEmailData checkEmailData = CheckEmailData(Get.find());
  final forgetPasswordFormKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  var email = TextEditingController();
  var isLoading = false.obs;

  checkEmailFunc() async {
    if (forgetPasswordFormKey.currentState!.validate() && !isLoading.value) {
      isLoading.value = true;
      statusRequest = StatusRequest.loading;

      var response = await checkEmailData.postdata(email.text);
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
