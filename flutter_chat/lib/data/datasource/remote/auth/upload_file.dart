import 'dart:io';

import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/data/models/user_model.dart';
import 'package:chat_application/links_api.dart';

class UploadFile {
  Crud crud;

  UploadFile(this.crud);

  postdataFiles(UserModel model, File files) async {
    var response = await crud.postDataFiles(AppLinks.uploadfile, model.toJson(), files: [files]);
    return response.fold((l) => l, (r) => r);
  }
}
