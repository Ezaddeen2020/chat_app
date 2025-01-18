// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:chatapp/data/models/chat_model.dart';
import 'package:chatapp/data/models/preferences.dart';
import 'package:chatapp/data/models/user_model.dart';
import 'package:chatapp/links_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

class SocketClass {
  static String server = AppLinks.server;

  static const headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};

  // AppLinks.
  // socketConnect() {
  //   var user = Preferences.getDataUser();
  //   if (user != null) {
  //     socket = IO.io('${AppLinks.server}?userId=${user.userId}', {
  //       'transports': ['websocket'],
  //       'autoConnect': false
  //     });
  //     socket?.connect();
  //     socket?.onConnect((_) {
  //       log('connect*--------');
  //       // log('connect*---------------------------------------------------$_');
  //     });

  //     socket?.onDisconnect((_) {
  //       print('Disconnected from the server');
  //     });
  //   }
  // }

  socketConnect() {
    if (socket != null && socket!.connected) {
      log("Socket already connected");
      return;
    }
    var user = Preferences.getDataUser();
    if (user != null) {
      socket = IO.io('${AppLinks.server}?userId=${user.userId}', {
        'transports': ['websocket'],
        'autoConnect': false
      });
      socket?.connect();
      socket?.onConnect((_) {
        log('connect*--------');
      });

      socket?.onDisconnect((_) {
        print('Disconnected from the server');
      });
    }
  }

  static void disconnect() {
    if (socket != null && socket!.connected) {
      socket?.disconnect();
      log("Socket disconnected");
    }
  }

  static void sendMessage(ChatModel chatmodel, UserModel userReceiver) {
    // log("-------------------------------------------------");
    var userSender = Preferences.getDataUser();
    var maps = {
      "msg": chatmodel.toJsonSocket(),
      "receiver": userReceiver.toJson(),
      "sender": userSender!.toJson()
    };
    log("${maps}Data before socket ssssssssssssssssssssssssssss");
    if (socket?.connected ?? false) {
      socket?.emit('message', maps);
    } else {
      print("Socket is not connected.");
    }
  }
}



// لديك المتغير socket معرف بشكل عام (Global) في الكود، مما يعني أنه يمكن الوصول إليه من أي مكان، ولكن إذا تم إعادة استدعاء socketConnect أكثر من مرة دون فصل الاتصال السابق، قد يتم إنشاء اتصال جديد