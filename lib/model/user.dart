import 'package:flutter/material.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:sqflite/sqflite.dart';

class User {
  User(
      {@required this.id,
      @required this.account,
      @required this.password,
      this.name,
      this.image,
      this.userSM,
      this.firendCode});
  String id;
  String account;
  String password;
  String name;
  String image;
  String userSM;
  String firendCode;
  static final String _tableName = "tb_userInfo";
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "account": account,
      "password": password,
      "userSM": userSM,
      "name": name,
      "image": image,
      "firendCode": firendCode,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.account = map['account'];
    this.password = map['password'];
    this.userSM = map['userSM'];
    this.name = map['name'];
    this.image = map['image'];
    this.firendCode = map['firendCode'];
  }
  static createTable(Database db) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [_tableName]);
    if (result.isEmpty) {
      await DBHelper().createTable(
        tableName: _tableName,
        columns: {
          "id": "TEXT  PRIMARY KEY",
          "account": "TEXT",
          "password": "TEXT",
          "userSM": "TEXT",
          "name": "TEXT",
          "image": "TEXT",
          "firendCode": "TEXT",
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
