import 'package:flutter/material.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:sqflite/sqflite.dart';

class Friend {
  Friend(
      {@required this.id,
      @required this.name,
      this.image,
      this.userSM = "",
      isFriend = true});
  String id;
  String name;
  String image;
  String userSM;
  bool isFriend;
  static final String _tableName = "tb_friend";
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "userSM": userSM,
      "isFriend": isFriend
    };
    return map;
  }

  Friend.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.userSM = map['userSM'] ?? "";
    this.image = map['image'] ?? "";
    this.isFriend = map['isFriend'] ?? true;
  }
  static createTable(Database db) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [_tableName]);
    if (result.isEmpty) {
      await DBHelper().createTable(
        tableName: _tableName,
        columns: {
          "id": "TEXT  PRIMARY KEY",
          "name": "TEXT",
          "image": "TEXT",
          "userSM": "TEXT",
          "isFriend": "INTEGER"
        },
      );
    } else {
      getLogger("Friend").e("table exist");
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
