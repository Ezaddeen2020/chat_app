import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  String? replayMsg;
  String msg;
  List<String>? mediaData;
  bool editMsgbyKey;
  bool isReplaied;
  bool delMsgbykey;

  MessageModel(
      {this.replayMsg,
      required this.msg,
      this.mediaData,
      this.editMsgbyKey = false,
      this.isReplaied = false,
      this.delMsgbykey = false});

  MessageModel copyWith({
    String? replayMsg,
    String? msg,
    bool? editMsgbyKey,
    bool? isReplaied,
    bool? delMsgbykey,
    List<String>? mediaData,
  }) {
    return MessageModel(
      replayMsg: replayMsg ?? this.replayMsg,
      msg: msg ?? this.msg,
      editMsgbyKey: editMsgbyKey ?? this.editMsgbyKey,
      isReplaied: isReplaied ?? this.isReplaied,
      delMsgbykey: delMsgbykey ?? this.delMsgbykey,
      mediaData: mediaData ?? this.mediaData,
    );
  }

  //convert the MessageModel toMap which is useful for the Object JSON
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'replayMsg': replayMsg,
      'msg': msg,
      'mediaData': mediaData,
      'editMsgbyKey': editMsgbyKey,
      'isReplaied': isReplaied,
      'delMsgbykey': delMsgbykey,
    };
  }

  //factory constructor creates a MessageModel instance from  a Map<String,dynamic>
  //it is useful when receive data in map (from JSON object) and want to convert it into MessageModle instanc
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      replayMsg: map['replayMsg'] != null ? map['replayMsg'] as String : null,
      // replayMsg: map['replayMsg'] as String?,
      msg: map['msg'] as String,
      mediaData: map['mediaData'] != null
          ? List<String>.from((map['mediaData'] as List<dynamic>).map((e) => e as String))
          : null,
      // editMsgbyKey: map['editMsgbyKey'] as bool,
      editMsgbyKey: map['editMsgbyKey'],
      isReplaied: map['isReplaied'] ?? false,
      delMsgbykey: map['delMsgbykey'],
    );
  }

  //json.encode() purpose: Converts a Dart object (like a Map or List) into a JSON string.
  //Use Case: When you need to send data to a server or save it as a JSON string.
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toJsonSocket() {
    return {
      'replayMsg': replayMsg,
      'msg': msg,
      'mediaData': mediaData,
      'editMsgbyKey': editMsgbyKey ? 1 : 0,
      'isReplaied': isReplaied ? 1 : 0,
      'delMsgbykey': delMsgbykey ? 1 : 0,
    };
  }

  factory MessageModel.fromJson(String source) {
    try {
      // print('Parsing JSON: $source'); // سجل البيانات التي تحاول تحليلها

      final Map<String, dynamic> map = json.decode(source) as Map<String, dynamic>;
      return MessageModel.fromMap(map);
    } catch (e) {
      print('Error: $e'); // Log the error for more insight
      throw FormatException("Invalid JSON format: $source");
    }
  }
}
