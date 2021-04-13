import 'package:flutter/material.dart';

class Message {
  Message({@required this.messageContent, @required this.messageSender});
  final MessageContent messageContent;
  final MessageSender messageSender;
}

class MessageContent {
  MessageContent({@required this.messageType, @required this.messageRowData});
  final MessageType messageType;
  final Map messageRowData;
  dynamic messageData;
  String get showMessage {
    switch (MessageType.values[messageRowData["type"]]) {
      case MessageType.TEXT:
        messageData = TextMessageData(
          id: messageRowData["id"],
          senderId: messageRowData["sender"],
          sendTime:
              DateTime.fromMillisecondsSinceEpoch(messageRowData["timestamp"]),
          text: messageRowData["content"],
        );
        break;
      default:
        messageData = BaseMessageData();
        break;
    }
    return messageData.showMessage;
  }
}

class MessageSender {
  MessageSender(
      {@required this.name, @required this.id, @required this.imageUrl});
  final String name;
  final String id;
  final String imageUrl;
}

class BaseMessageData {
  String get showMessage {
    return "訊息發生錯誤";
  }
}

class TextMessageData extends BaseMessageData {
  TextMessageData(
      {@required this.text,
      @required this.id,
      @required this.senderId,
      @required this.sendTime});
  final String text;
  final String id;
  final String senderId;
  final DateTime sendTime;
  @override
  String get showMessage {
    return this.text;
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
