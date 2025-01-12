import 'dart:developer';

import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/links_api.dart';
import 'package:chat_application/controller/home_controller.dart';

class LoadMsgData {
  Crud crud;

  LoadMsgData(this.crud);

  final HomeController homeController = HomeController();
  loadMsg(int senderId, int receiverId) async {
    var response = await crud.getData('${AppLinks.loadMessage}/$senderId/$receiverId');
    return response.fold((l) => l, (r) => r);
  }
}
