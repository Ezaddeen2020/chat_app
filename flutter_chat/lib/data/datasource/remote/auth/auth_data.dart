import 'package:chatapp/core/classes/crud.dart';
import 'package:chatapp/data/models/user_model.dart';
import 'package:chatapp/links_api.dart';

class AuthData {
  Crud crud;

  AuthData(this.crud);

  Future<dynamic> loginFun(UserModel model) async {
    var response = await crud.postData(AppLinks.login, model.toJson());
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> checkEmailFun(String email) async {
    var response = await crud.postData(AppLinks.checkEmail, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> resendCode(String email, String idOtp) async {
    var response = await crud.postData(AppLinks.resend, {
      "email": email,
      "id_otp": idOtp,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> signUpFunc(UserModel model) async {
    var response = await crud.postData(AppLinks.signUp, model.toJson());
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> verifyCodeFun(String verifyCode, String idotp) async {
    var response =
        await crud.postData(AppLinks.verifcodeSignup, {"code": verifyCode, "id_otp": idotp});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> resetPassFun(String email, String password, String idotp) async {
    var response = await crud
        .postData(AppLinks.resetPassword, {"email": email, "password": password, "id_otp": idotp});
    return response.fold((l) => l, (r) => r);
  }
}
