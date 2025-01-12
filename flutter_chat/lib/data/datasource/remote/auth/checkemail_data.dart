import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/links_api.dart';

class CheckEmailData {
  Crud crud;

  CheckEmailData(this.crud);

  postdata(String email) async {
    var response = await crud.postData(AppLinks.checkEmail, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
