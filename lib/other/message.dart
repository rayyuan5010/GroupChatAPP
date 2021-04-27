import 'package:flutter/material.dart';

class Message {
  MessageContent messageContent;
  MessageSender messageSender;
  Message(Map messageRowData) {
    this.messageContent = new MessageContent(messageRowData);
    this.messageSender = new MessageSender(messageRowData);
  }
}

class MessageContent {
  /*
  {
    // "senderId":"id",
    // "senderName":"name",
    // "to":"",
    // "reciveType":"",
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

  MessageContent(Map rd) {
    this.id = rd['messageId'];
    this.reciveTime = DateTime.fromMillisecondsSinceEpoch(rd['messageTime']);
    this.content = rd['messageContent'];
    this.tabId = rd['messageTabId'];

    this.messageType = MessageType.values[rd['messageType']];

    this.reciveType = ReciveType.values[rd['reciveType']];
    this.to = List.from(rd['to']);
  }
}

class MessageSender {
  String name;
  String id;
  String imageUrl;
  MessageSender(Map rd) {
    this.name = rd['senderName'];
    this.id = rd['senderId'];
    this.imageUrl = rd['senderImage'];
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
