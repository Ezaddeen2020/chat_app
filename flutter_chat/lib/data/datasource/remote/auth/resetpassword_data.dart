import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/links_api.dart';

class ResetpasswordData {
  Crud crud;

  ResetpasswordData(this.crud);

  postdata(String email, String password, String idotp) async {
    var response = await crud
        .postData(AppLinks.resetPassword, {"email": email, "password": password, "id_otp": idotp});
    return response.fold((l) => l, (r) => r);
  }
}
