import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_database.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class Room extends DataBaseBasic {
  Room({this.id, this.name, this.image, this.lastMessage, this.isGroup = true});
  String id;
  String name;
  String image;
  String lastMessage;
  bool isGroup;

  // bool isFriend;
  static final String tableName = "tb_room";
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "lastMessage": lastMessage,
      "isGroup": isGroup ? 1 : 0
    };
    return map;
  }

  Room.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.image = map['image'] ?? "";
    this.lastMessage = map['lastMessage'] ?? "";
    print(map["isGroup"]);
    if (map["isGroup"].runtimeType == int) {
      this.isGroup = map['isGroup'] == 1 ? true : false;
    } else {
      this.isGroup = map['isGroup'];
    }
  }
  createTable(Database db) async {
    super.create(db, tableName, {
      "id": "TEXT  PRIMARY KEY",
      "name": "TEXT",
      "image": "TEXT",
      "lastMessage": "TEXT",
      "isGroup": "INTEGER"
    });
  }

  dropTable(Database db) async {
    super.drop(db, tableName);
  }

  clearTable(Database db) {
    super.clear(db, tableName);
  }
}
