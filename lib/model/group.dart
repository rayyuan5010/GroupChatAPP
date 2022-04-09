import 'package:flutter/material.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:sqflite/sqflite.dart';

//{
//createdAt: 2022-03-02 03:48:12,
//deletedAt: null,
//id: 4Dtmfhh7j29wDiKTz4RXRAC5pYGA,
//image: null,
//name: 新群組,
//owner: 5UZcmL5LtuWQkVe7JiqZ,
//updatedAt: null
//}
class Group {
  Group(
      {@required this.id,
      @required this.name,
      @required this.owner,
      this.image});
  String id;
  String name;
  String owner;
  String image;
  static final String _tableName = "tb_group";
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "owner": owner,
    };
    return map;
  }

  Group.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.owner = map['owner'];
    this.image = map['image'] ?? "";
  }
  static createTable(Database db) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [_tableName]);
    if (result.isEmpty) {
      await DBHelper().createTable(
        db: db,
        tableName: _tableName,
        columns: {
          "id": "TEXT  PRIMARY KEY",
          "name": "TEXT",
          "image": "TEXT",
          "owner": "TEXT"
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
