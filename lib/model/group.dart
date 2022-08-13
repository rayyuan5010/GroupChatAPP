import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_database.dart';
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
class Group extends DataBaseBasic {
  Group({this.id, this.name, this.owner, this.image});
  String id;
  String name;
  String owner;
  String image;
  static final String tableName = "tb_group";
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

  createTable(Database db) {
    super.create(db, tableName, {
      "id": "TEXT  PRIMARY KEY",
      "name": "TEXT",
      "image": "TEXT",
      "owner": "TEXT"
    });
  }

  dropTable(Database db) {
    super.drop(db, tableName);
  }

  clearTable(Database db) {
    super.clear(db, tableName);
  }
}
