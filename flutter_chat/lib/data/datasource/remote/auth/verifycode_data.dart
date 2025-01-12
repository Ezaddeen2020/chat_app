import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/links_api.dart';

class VerifycodeData {
  Crud crud;
  VerifycodeData(this.crud);

  postCode(String verifyCode, String idotp) async {
    var response =
        await crud.postData(AppLinks.verifcodeSignup, {"code": verifyCode, "id_otp": idotp});
    return response.fold((l) => l, (r) => r);
  }
}
