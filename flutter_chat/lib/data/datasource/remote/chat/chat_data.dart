import 'dart:developer';
import 'dart:io';
import 'package:chatapp/core/classes/crud.dart';
import 'package:chatapp/data/models/chat_model.dart';
import 'package:chatapp/data/models/user_model.dart';
import 'package:chatapp/links_api.dart';

class ChatData {
  Crud crud;
  final Map<String, dynamic> _cache = {}; // تخزين مؤقت للبيانات

  ChatData(this.crud);

//====================== Fetch Msg Data ========================//
  Future<dynamic> fetchdata(int userId) async {
    final cacheKey = 'fetchdata_$userId';

    // التحقق من وجود البيانات في التخزين المؤقت
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    var response = await crud.getData('${AppLinks.getMessage}/$userId');
    log('========= Fetch Data from Server =========${response.toString()}');

    // تخزين البيانات في التخزين المؤقت
    _cache[cacheKey] = response.fold((l) => l, (r) => r);

    return _cache[cacheKey];
  }

  Future<dynamic> getNotViewMsg(int userId) async {
    final cacheKey = 'getNotViewMsg_$userId';

    // التحقق من وجود البيانات في التخزين المؤقت
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    var response = await crud.getData('${AppLinks.getMsgNotView}/$userId');
    log('========= Fetch Data from Server =========${response.toString()}');

    // تخزين البيانات في التخزين المؤقت
    _cache[cacheKey] = response.fold((l) => l, (r) => r);

    return _cache[cacheKey];
  }

//====================== load Msg Data ========================//

  Future<dynamic> loadMsg(int senderId, int receiverId) async {
    final cacheKey = 'loadMsg_$senderId\_$receiverId';

    // التحقق من وجود البيانات في التخزين المؤقت
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }

    var response = await crud.getData('${AppLinks.loadMessage}/$senderId/$receiverId');

    // تخزين البيانات في التخزين المؤقت
    _cache[cacheKey] = response.fold((l) => l, (r) => r);

    return _cache[cacheKey];
  }

//====================== Add Msg Data ========================//
  Future<dynamic> addMsgFun(ChatModel msgchatMode) async {
    var response = await crud.postData(AppLinks.addmessage, msgchatMode.toJson());
    // log('========= add data =========${response.toString()}');
    return response.fold((l) => l, (r) => r);
  }

//====================== Edit Msg Data ========================//
  Future<dynamic> editMsgData(ChatModel editMsgModel) async {
    var response = await crud.postData(AppLinks.editMessage, {
      "msg": editMsgModel.message,
      "msgKey": editMsgModel.msgKey,
      "msgView": editMsgModel.msgView,
    });
    return response.fold((l) => l, (r) => r);
  }

//====================== Delete Msg Data ========================//
  Future<dynamic> delMsgData(ChatModel delMsgkey) async {
    var response = await crud.postData(AppLinks.delMessage, {'msgkey': delMsgkey});
    log(response.toString());
    return response.fold((l) => l, (r) => r);
  }

//====================== Upload File Data ========================//
  Future<dynamic> postdataFiles(UserModel model, File? files) async {
    var response = await crud.postDataFiles(AppLinks.uploadfile, model.toJson(),
        files: files != null ? [files] : []);
    return response.fold((l) => l, (r) => r);
  }
}








//   fetchAndSendContacts(List<ChatUserModel> contacts) async {
//     // جمع الأرقام والأسماء ككائنات JSON
//     List<Map<String, String>> contactData = contacts
//       .map((e) => {
//             "user_phone": e.user.userPhone, // رقم الهاتف
//             "user_name": e.user.userName    // اسم جهة الاتصال
//           })
//       .where((contact) => contact["user_phone"]!.isNotEmpty) // التأكد من أن الرقم ليس فارغًا
//       .toList();

//   var response = await crud.postData(AppLinks.fetchUsers, {"contacts": contactData});
//   return response.fold((r) => r, (l) => l);
//   }


// import 'dart:developer';
// import 'package:chatapp/core/classes/crud.dart';
// import 'package:chatapp/links_api.dart';

// class ChatData {
//   Crud crud;

//   ChatData(this.crud);

//   fetchdata(int userId) async {
//     var response = await crud.getData('${AppLinks.getMessage}/$userId');
//     log('========= Fetch Data from Server =========${response.toString()}');
//     return response.fold((l) => l, (r) => r);
//   }

//   getNotViewMsg(int userId) async {
//     var response = await crud.getData('${AppLinks.getMsgNotView}/$userId');
//     log('========= Fetch Data from Server =========${response.toString()}');
//     return response.fold((l) => l, (r) => r);
//   }
// }
