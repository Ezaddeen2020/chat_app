import 'dart:developer';
import 'dart:io';
import 'package:chat_application/core/classes/status_request.dart';
import 'package:chat_application/core/constant/routes.dart';
import 'package:chat_application/core/functions/handling_data.dart';
import 'package:chat_application/data/datasource/remote/auth/signup_data.dart';
import 'package:chat_application/data/datasource/remote/auth/upload_file.dart';
import 'package:chat_application/data/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
  goToNextPage();
}

class SignUpControllerImp extends SignUpController {
  //=======  Parameters of Sign up  =========//
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  late SignupData signupdata = SignupData(Get.find());
  late UploadFile uploadFile = UploadFile(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController token;
  final ImagePicker _picker =
      ImagePicker(); //تحديد مصدر الصورة كاميرا او معرض و القيام بعملية الالتقاط  او اختيارها
  File? userImage; //يستخدم لتخزين الصورة التي تم اختيارها من قبل المستخدم

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    token = TextEditingController();

    super.onInit();
  }

  //=============  Taking Image Function  =================//
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage = File(image.path); //File because to control the display of the image
      update();
    }
  }

  //=============  Sign Up Function  =================//
  @override
  signUp() async {
    if (signupFormKey.currentState!.validate()) {
      // statusRequest = StatusRequest.loading;
      // update();
      var token = await FirebaseMessaging.instance.getToken();
      var userModel = UserModel(
        userId: 0,
        userName: username.text,
        userEmail: email.text,
        userPassword: password.text,
        userPhone: phone.text,
        token: token ?? '',
        user: "",
        userStatus: "",
        userImg: userImage?.path.split("/").last,
      );
      // log(userModel.toJson().toString());
      // print("9999999999999999999999999999999999999999999999999999999999999");
      var res = await uploadFile.postdataFiles(userModel, userImage!);
      if (res['status'] == "success") {
        var response = await signupdata.postdata(userModel);
        // log("=========================$response");
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            Get.offNamed(
              AppRoute.emailVerifyCode,
              arguments: {
                'email': email.text,
                "password": password.text,
                "id_otp": response['id_otp'],
                "page": "signup"
              },
            );
          } else {
            Get.defaultDialog(
                title: "Warning", middleText: response['message'] ?? "Email is already exists");
            statusRequest = StatusRequest.failure;
          }
        }
      }
      update();
    }
  }

  @override
  goToNextPage() {
    // if()
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    token.dispose();
    super.onClose();
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }
}