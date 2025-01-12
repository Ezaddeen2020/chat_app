import 'package:chat_application/core/classes/crud.dart';
import 'package:chat_application/data/models/chat_user_model.dart';
import 'package:chat_application/links_api.dart';

class FetchUserData {
  final Crud crud;
  FetchUserData(this.crud);

  fetchAndSendContacts(List<ChatUserModel> contacts) async {
    // جمع الأرقام والأسماء ككائنات JSON
    List<Map<String, String>> contactData = contacts
        .map((e) => {
              "user_phone": e.user.userPhone, // رقم الهاتف
              "user_name": e.user.userName // اسم جهة الاتصال
            })
        .where((contact) => contact["user_phone"]!.isNotEmpty) // التأكد من أن الرقم ليس فارغًا
        .toList();

    var response = await crud.postData(AppLinks.fetchUsers, {"contacts": contactData});
    return response.fold((r) => r, (l) => l);
  }
}
