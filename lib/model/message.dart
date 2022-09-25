import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_database.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class Message extends DataBaseBasic {
  Message(
      {this.senderId,
      this.senderName,
      this.reciver,
      this.reciveType,
      this.messageId,
      this.messageType,
      this.messageTime,
      this.messageContent,
      this.messageTabId,
      this.groupId}) {
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

    if (senderId != null) {
      this.messageDetail = new MessageDetail(messageRowData);
      this.messageSender = new MessageSender(messageRowData);
    }
  }
  static String tableName = "tb_message";
  String senderId;
  String senderName;
  String reciver;
  int reciveType;
  String messageId;
  int messageType;
  int messageTime;
  String messageContent;
  int messageTabId;
  String groupId;
  MessageDetail messageDetail;
  MessageSender messageSender;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "senderId": messageSender.id,
      "senderName": messageSender.name,
      "reciver": reciver,
      "reciveType": messageDetail.reciveType.index,
      "messageContent": messageContent,
      "messageId": messageDetail.id,
      "messageType": messageDetail.messageType.index,
      "messageTime": messageTime,
      "messageTabId": messageDetail.tabId,
      "groupId": messageSender.groupId,
    };
    return map;
  }

  Message.fromMap(Map<String, dynamic> map) {
    this.senderId = map["senderId"];
    this.senderName = map["senderName"];
    this.reciver = map["reciver"];
    if (map["reciveType"].runtimeType == int) {
      this.reciveType = map["reciveType"];
    } else {
      this.reciveType = int.parse(map["reciveType"]);
    }

    this.messageId = map["messageId"];
    this.messageContent = map["messageContent"];
    if (map["messageType"].runtimeType == int) {
      this.messageType = map["messageType"];
    } else {
      this.messageType = int.parse(map["messageType"]);
    }
    if (map["messageTime"].runtimeType == int) {
      this.messageTime = map["messageTime"];
    } else {
      this.messageTime = int.parse(map["messageTime"]);
    }

    this.messageTabId = int.parse(map["messageTabId"]);
    this.groupId = map["groupId"] ?? "";
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

  createTable(Database db) {
    super.create(db, tableName, {
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
    });
  }

  dropTable(Database db) {
    super.drop(db, tableName);
  }

  clearTable(Database db) {
    super.clear(db, tableName);
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
  int tabId;
  ReciveType reciveType;
  List<String> reciver;
  // Map messageRowData;
  // dynamic messageData;

  MessageDetail(Map rd) {
    this.id = rd['messageId'];
    this.reciveTime = DateTime.fromMillisecondsSinceEpoch(rd["messageTime"]);
    this.content = rd['messageContent'];
    this.tabId = rd['messageTabId'];

    this.messageType = MessageType.values[rd['messageType']];

    this.reciveType = ReciveType.values[rd['reciveType']];
    // if (rd['reciver'] != '' && rd['reciver'] != null) {
    //   this.reciver = List.from(rd['reciver']);
    // }
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
