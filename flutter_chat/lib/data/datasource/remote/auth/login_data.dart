import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/data/models/user_model.dart';
import 'package:chat_application/links_api.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  postdata(UserModel model) async {
    var response = await crud.postData(AppLinks.login, model.toJson());
    return response.fold((l) => l, (r) => r);
  }
}
