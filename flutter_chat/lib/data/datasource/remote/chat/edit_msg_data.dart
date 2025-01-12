import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/links_api.dart';
import 'package:chat_application/data/models/chat_model.dart';

class EditMsgData {
  Crud crud;

  EditMsgData(this.crud);

  editMsgData(ChatModel editMsgModel) async {
    var response = await crud.postData(AppLinks.editMessage, {
      "msg": editMsgModel.message,
      "msgKey": editMsgModel.msgKey,
      "msgView": editMsgModel.msgView,
    });
    return response.fold((l) => l, (r) => r);
  }
}
