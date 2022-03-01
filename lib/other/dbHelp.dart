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
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tb_userInfo (id TEXT PRIMARY KEY, account TEXT , password TEXT ,firendCode TEXT ,name TEXT,userSM TEXT ,image TEXT)');

    // await db.insert('tb_setting', {"title": "account", "data": ""});
    // await db.insert('tb_setting', {"title": "account", "data": ""});
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
