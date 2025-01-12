import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/data/models/user_model.dart';
import 'package:chat_application/links_api.dart';

class SignupData {
  Crud crud;

  SignupData(this.crud);

  postdata(UserModel model) async {
    var response = await crud.postData(AppLinks.signUp, model.toJson());
    return response.fold((l) => l, (r) => r);
  }
}
 




 

 
// import 'dart:io';

// import 'package:chat_application/core/classes/crud.dart';
// import 'package:chat_application/data/models/user_model.dart';
// import 'package:chat_application/links_api.dart';

// class SignupData { 
//   Crud crud;

//   SignupData(this.crud);

//   postdata(UserModel model) async {
//   var response = await crud.postData(AppLinks.signUp, model.toJson(), image: model.userImg != null ? File(model.userImg!) : null);
//   return response.fold((l) => l, (r) => r);
// }
// }
