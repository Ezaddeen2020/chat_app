import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/data/models/chat_model.dart';
import 'package:chat_application/links_api.dart';

class AddMessages {
  Crud crud;

  AddMessages(this.crud);

  addMsgFun(ChatModel msgchatMode) async {
    var response = await crud.postData(AppLinks.addmessage, msgchatMode.toJson());
    // log('========= add data =========${response.toString()}');
    return response.fold((l) => l, (r) => r);
  }
}
