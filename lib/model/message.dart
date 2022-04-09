import 'package:flutter/material.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:sqflite/sqflite.dart';

class Message {
  Message(
      {@required this.senderId,
      @required this.senderName,
      @required this.reciver,
      @required this.reciveType,
      @required this.messageId,
      @required this.messageType,
      @required this.messageTime,
      @required this.messageContent,
      @required this.messageTabId,
      @required this.groupId}) {
    Map messageRowData = {
      "senderId": senderId,
      "senderName": senderName,
      "reciver": reciver,
      "reciveType": reciveType,
      "messageContent": messageContent,
      "messageId": messageId,
      "messageType": messageType,
      "messageTime": messageTime,
      "messageTabId": messageTabId,
      "groupId": groupId,
    };
    this.messageDetail = new MessageDetail(messageRowData);
    this.messageSender = new MessageSender(messageRowData);
  }
  static String _tableName = "tb_message";
  String senderId;
  String senderName;
  String reciver;
  int reciveType;
  String messageId;
  int messageType;
  int messageTime;
  String messageContent;
  String messageTabId;
  String groupId;
  MessageDetail messageDetail;
  MessageSender messageSender;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "senderId": messageSender.id,
      "senderName": messageSender.name,
      "reciver": messageDetail.reciver,
      "reciveType": messageDetail.reciveType,
      "messageContent": messageContent,
      "messageId": messageDetail.id,
      "messageType": messageDetail.messageType,
      "messageTime": messageDetail.reciveTime,
      "messageTabId": messageDetail.tabId,
      "groupId": messageSender.groupId,
    };
    return map;
  }

  Message.fromMap(Map<String, dynamic> map) {
    this.senderId = map["senderId"];
    this.senderName = map["senderName"];
    this.reciver = map["reciver"];
    this.reciveType = map["reciveType"];
    this.messageId = map["messageId"];
    this.messageContent = map["messageContent"];
    this.messageType = map["messageType"];
    this.messageTime = map["messageTime"];
    this.messageTabId = map["messageTabId"];
    this.groupId = map["groupId"];
    Map messageRowData = {
      "senderId": this.senderId,
      "senderName": this.senderName,
      "reciver": this.reciver,
      "reciveType": this.reciveType,
      "messageId": this.messageId,
      "messageType": this.messageType,
      "messageContent": this.messageContent,
      "messageTime": this.messageTime,
      "messageTabId": this.messageTabId,
      "groupId": this.groupId,
    };
    this.messageDetail = new MessageDetail(messageRowData);
    this.messageSender = new MessageSender(messageRowData);
  }
  static createTable(Database db) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [_tableName]);
    if (result.isEmpty) {
      await DBHelper().createTable(
        db: db,
        tableName: _tableName,
        columns: {
          "senderId": "TEXT",
          "senderName": "TEXT",
          "reciver": "TEXT",
          "reciveType": "INTEGER",
          "messageId": "TEXT  PRIMARY KEY",
          "messageContent": "TEXT",
          "messageType": "INTEGER",
          "messageTime": "DATETIME",
          "messageTabId": "TEXT",
          "groupId": "TEXT",
        },
      );
    } else {
      getLogger("Group").e("table exist");
    }
  }

  static dropTable(Database db) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [_tableName]);
    if (result.isNotEmpty) {
      await db.execute("DROP TABLE $_tableName");
    } else {
      return false;
    }
    return true;
  }
}

class MessageDetail {
  /*
  {
    "senderId":"id",
    "senderName":"name",
    "to":"",
    "reciveType":"",
    "messageId":"",
    "messageType":"",
    "messageTime":"",
    "messageContent":"",
    "messageTabId":""
}

  */
  MessageType messageType;
  String id;
  DateTime reciveTime;
  String content;
  String tabId;
  ReciveType reciveType;
  List<String> reciver;
  // Map messageRowData;
  // dynamic messageData;

  MessageDetail(Map rd) {
    print(rd);
    // print(type(rd));
    this.id = rd['messageId'];
    this.reciveTime = DateTime.fromMillisecondsSinceEpoch(rd["messageTime"]);
    this.content = rd['messageContent'];
    this.tabId = rd['messageTabId'];

    this.messageType = MessageType.values[rd['messageType']];

    this.reciveType = ReciveType.values[rd['reciveType']];
    if (rd['reciver'] != '') {
      this.reciver = List.from(rd['reciver']);
    }
  }
}

class MessageSender {
  String name;
  String id;
  String imageUrl;
  String groupId;
  MessageSender(Map rd) {
    this.name = rd['senderName'];
    this.id = rd['senderId'];
    this.imageUrl = rd['senderImage'];
    this.groupId = rd['groupId'];
  }
}

enum MessageType {
  TEXT,
  STIKER,
  IMAGE,
  FILE,
  MAPMARKER,
  MAPPATH,
  DRAW,
}
enum ReciveType { PUBLIC, PRIVATE }
