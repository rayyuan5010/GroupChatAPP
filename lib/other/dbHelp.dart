import 'package:flutter/material.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/group.dart';
import 'package:group_chat/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'main.db');
    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  _onUpgrade(Database db, int version, int version2) async {
    await Friend.dropTable(db);
    await Group.dropTable(db);
    await User.dropTable(db);

    await Friend.createTable(db);
    await Group.createTable(db);
    await User.createTable(db);
  }

  _onCreate(Database db, int version) async {
    await Friend.createTable(db);
    await Group.createTable(db);
    await User.createTable(db);
  }

  Future createTable(
      {@required String tableName, @required Map columns}) async {
    String columnsSQL = "";
    columns.forEach((key, value) {
      columnsSQL += "$key $value ,";
    });
    columnsSQL += "createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,";
    columnsSQL += "updatedAt DATETIME,";
    columnsSQL += "deletedAt DATETIME";

    // columnsSQL = columnsSQL.substring(0, columnsSQL.length - 1);

    String sql = "CREATE TABLE $tableName ($columnsSQL)";
    try {
      await _db.execute(sql);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> checkLogin() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(
      'tb_userInfo',
    );
    if (maps.length > 0) {
      return User.fromMap(maps[0]);
    } else {
      return null;
    }
  }
}
