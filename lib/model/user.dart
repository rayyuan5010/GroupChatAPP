import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_database.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:sqflite/sqflite.dart';

class User extends DataBaseBasic {
  User(
      {this.id,
      this.account,
      this.password,
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
  static final String tableName = "tb_userInfo";
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

  createTable(Database db) {
    super.create(db, tableName, {
      "id": "TEXT  PRIMARY KEY",
      "account": "TEXT",
      "password": "TEXT",
      "userSM": "TEXT",
      "name": "TEXT",
      "image": "TEXT",
      "firendCode": "TEXT",
    });
  }

  dropTable(Database db) {
    super.drop(db, tableName);
  }

  clearTable(Database db) {
    super.clear(db, tableName);
  }
}
