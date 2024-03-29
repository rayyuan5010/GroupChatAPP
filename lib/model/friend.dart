import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_database.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:sqflite/sqflite.dart';

class Friend extends DataBaseBasic {
  Friend({this.id, this.name, this.image, this.userSM = "", isFriend = true});
  String id;
  String name;
  String image;
  String userSM;
  // bool isFriend;
  static final String tableName = "tb_friend";
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "userSM": userSM,
      // "isFriend": isFriend ? 1 : 0
    };
    return map;
  }

  Friend.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.userSM = map['userSM'] ?? "";
    this.image = map['image'] ?? "";
    // this.isFriend = map['isFriend'] ?? true;
  }

  createTable(Database db) {
    super.create(db, tableName, {
      "id": "TEXT  PRIMARY KEY",
      "name": "TEXT",
      "image": "TEXT",
      "userSM": "TEXT"
    });
  }

  dropTable(Database db) {
    super.drop(db, tableName);
  }

  clearTable(Database db) {
    super.clear(db, tableName);
  }
}
