import 'dart:developer';
import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/data/models/chat_model.dart';
import 'package:chat_application/links_api.dart';

class DeleteMsgData {
  Crud crud;
  DeleteMsgData(this.crud);

  delMsgData(ChatModel delMsgkey) async {
    var response = await crud.postData(AppLinks.delMessage, {'msgkey': delMsgkey});
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }
}
