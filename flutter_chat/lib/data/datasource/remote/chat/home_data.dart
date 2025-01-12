import 'dart:developer';

import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/links_api.dart';

class HomeScreenData {
  Crud crud;

  HomeScreenData(this.crud);

  fetchdata(int userId) async {
    var response = await crud.getData('${AppLinks.getMessage}/$userId');
    log('========= Fetch Data from Server =========${response.toString()}');
    return response.fold((l) => l, (r) => r);
  }

  getNotViewMsg(int userId) async {
    var response = await crud.getData('${AppLinks.getMsgNotView}/$userId');
    log('========= Fetch Data from Server =========${response.toString()}');
    return response.fold((l) => l, (r) => r);
  }
}
