import 'package:flutter/material.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:sqflite/sqflite.dart';

class Message {
  Message(
      {@required this.senderId,
      @required this.senderName,
      @required this.to,
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
      "to": to,
      "reciveType": reciveType,
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
  String to;
  ReciveType reciveType;
  String messageId;
  MessageType messageType;
  String messageTime;
  String messageContent;
  String messageTabId;
  String groupId;
  MessageDetail messageDetail;
  MessageSender messageSender;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "senderId": messageSender.id,
      "senderName": messageSender.name,
      "to": messageDetail.to,
      "reciveType": messageDetail.reciveType,
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
    this.to = map["to"];
    this.reciveType = map["reciveType"];
    this.messageId = map["messageId"];
    this.messageType = map["messageType"];
    this.messageTime = map["messageTime"];
    this.messageTabId = map["messageTabId"];
    this.groupId = map["groupId"];
    Map messageRowData = {
      "senderId": this.senderId,
      "senderName": this.senderName,
      "to": this.to,
      "reciveType": this.reciveType,
      "messageId": this.messageId,
      "messageType": this.messageType,
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
        tableName: _tableName,
        columns: {
          "senderId": "TEXT",
          "senderName": "TEXT",
          "to": "TEXT",
          "reciveType": "TEXT",
          "messageId": "TEXT  PRIMARY KEY",
          "messageType": "TEXT",
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
  List<String> to;
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
    if (rd['to'] != '') {
      this.to = List.from(rd['to']);
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
