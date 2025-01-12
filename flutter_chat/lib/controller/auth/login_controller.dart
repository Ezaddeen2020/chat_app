import 'dart:developer';

import 'package:chat_application/data/datasource/remote/auth/login_data.dart';
import 'package:chat_application/controller/screens/user_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:chat_application/core/functions/handling_data.dart';
import 'package:chat_application/core/classes/status_request.dart';
import 'package:chat_application/data/models/preferences.dart';
import 'package:chat_application/data/models/user_model.dart';
import 'package:chat_application/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  void login();
  void homeScreen();
  void goToSignUp();
  void goToForgetPassword();
  // Future<void> loginWithGoogle();
}

class LoginControllerImp extends LoginController {
  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  late LoginData logindata = LoginData(Get.find());
  late TextEditingController email;
  late TextEditingController password;
  late String username;

  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // var isShowPassword = true.obs;

  // void showPassword() {
  //   isShowPassword.toggle();
  // }

  bool isShowPassword = true;
  void showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  void login() async {
    if (loginFormKey.currentState!.validate()) {
      _loginWith();
    } else {
      // handle invalid form state
    }
  }

  void loginFromSignup() async {
    _loginWith();
  }

  void _loginWith() async {
    statusRequest = StatusRequest.loading;
    var token = await FirebaseMessaging.instance.getToken();
    log("============ $token");
    update();
    var userModel = UserModel(
      userId: 0,
      userName: "",
      userEmail: email.text,
      userPassword: password.text,
      userPhone: '',
      token: token ?? "",
      user: "",
      userStatus: "",
      userImg: "",
    );

    final response = await logindata.postdata(userModel);
    log("========================= Controller $response");
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        try {
          if (response['page'] == "page_verifycode") {
            Get.offNamed(AppRoute.emailVerifyCode, arguments: {
              'email': email.text,
              'password': password.text,
              "id_otp": response['id_otp'],
              "page": "login"
            });
          } else {
            Map<String, dynamic> resdata = response['data'];
            resdata['token'] = token ??
                response['data'][
                    'token']; // response['data']['token'] لكن إذا لم يكن لديك رمز بمعنى التوكن فارغ فسيتم استخدام الرمز المميز الموجود في استجابة الخادم['token'] فسيتم تعيين هذا الرمز إلى Firebase إذا كان لديك رمز تم الحصول عليه من
            var user = UserModel.fromJson(resdata);
            Get.find<UserController>().setPreferenceUser(user);
            Preferences.setBoolean(Preferences.isLogin, true);
            Get.offNamed(AppRoute.successSignUp);
          }
        } catch (e) {}
      } else {
        Get.defaultDialog(title: "Warning", middleText: "Email Or Password Not Correct");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void dispose() {
    Get.delete<LoginControllerImp>(); // Dispose when not needed
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }

  @override
  void homeScreen() {
    Get.offNamed(AppRoute.successSignUp);
  }
}











  // @override
  // Future<void> loginWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) {
  //       // User canceled the sign-in
  //       return;
  //     }
      
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //     // Create a new credential
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase with the Google credentials
  //     UserCredential userCredential = await _auth.signInWithCredential(credential);
  //     User? user = userCredential.user;
 
  //     // هنا يمكنك استخدام معلومات المستخدم لإجراء أي عمليات إضافية مثل تخزين المستخدم في قاعدة البيانات
  //     // var token = await FirebaseMessaging.instance.getToken();
  //     var token = await FirebaseMessaging.instance.getToken();
  //       if (token == null) {
  //         log("Failed to retrieve token. Using empty string.");
  //         token = "";
  //       }

  //     var userModel = UserModel(
  //       userId: 0,
  //       userName: user?.displayName ?? '',
  //       userEmail: user?.email ?? '', 
  //       userPassword: '', // لا حاجة لكلمة مرور هنا
  //       userPhone: '',
  //       token: token ?? "",
  //       user: "",
  //       userStatus:    "",
  //       userImg: user?.photoURL ?? "",
  //     );

  //     final response = await logindata.postdata(userModel);
  //     log("========================= Controller $response");
  //     statusRequest = handlingData(response);
  //     if (statusRequest == StatusRequest.success) {
  //       if (response['status'] == "success") {
  //         Map<String, dynamic> resdata = response['data'];
  //         resdata['token'] = token ?? response['data']['token']; 
  //         var user = UserModel.fromJson(resdata);
  //         Get.find<UserController>().setPrefernceUser(user);
  //         Preferences.setBoolean(Preferences.isLogin, true);
  //         Get.offNamed(AppRoute.successSignUp);
  //       } else {
  //         Get.defaultDialog(
  //             title: "Warning", middleText: "Login with Google failed");
  //         statusRequest = StatusRequest.failure;
  //       }
  //     }
  //     update();
  //   } catch (error) {
  //     log("Error logging in with Google: $error");
  //     Get.defaultDialog(
  //         title: "Error", middleText: "An error occurred while logging in with Google");
  //   }
  // }



