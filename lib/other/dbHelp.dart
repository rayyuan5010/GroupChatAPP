import 'package:flutter/material.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/group.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/model/room.dart';
import 'package:group_chat/model/user.dart';
import 'package:group_chat/other/auth.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  int databaseVersion = 12;
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'main.db');
    var db = await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  _onUpgrade(Database db, int version, int version2) async {
    await Friend().dropTable(db);
    await Group().dropTable(db);
    // await User().dropTable(db);
    await Message().dropTable(db);
    await Room().dropTable(db);

    await Friend().createTable(db);
    await Group().createTable(db);
    // await User().createTable(db);
    await Message().createTable(db);
    await Room().createTable(db);
  }

  _onCreate(Database db, int version) async {
    await Friend().createTable(db);
    await Group().createTable(db);
    await User().createTable(db);
    await Message().createTable(db);
    await Room().createTable(db);
  }

  Future<User> checkLogin() async {
    var dbClient = await this.db;
    List<Map> maps = await dbClient.query(
      'tb_userInfo',
    );
    // getLogger(className: "maps[0]").d(maps[0]);
    if (maps.length > 0) {
      return User.fromMap(maps[0]);
    } else {
      return null;
    }
  }

  Future updateSelfInfo(User user) async {
    var dbClient = await this.db;
    Map userData = user.toMap();
    userData.remove('id');
    dbClient
        .update('tb_userInfo', userData, where: "id=?", whereArgs: [user.id]);
  }

  //NOTE use id to search friend
  Future getFriendInfoByID(String id) async {
    var dbClient = await this.db;
    List<Map> friend =
        await dbClient.query(Friend.tableName, where: "id=?", whereArgs: [id]);
    print(friend);
    if (friend.length > 0) {
      return Friend.fromMap(friend[0]);
    } else {
      return null;
    }
  }

  Future<List<Friend>> getFriends() async {
    var dbClient = await this.db;
    List<Map> friends = await dbClient.query(Friend.tableName);

    List<Friend> temp = [];
    friends.forEach((element) {
      temp.add(Friend.fromMap(element));
    });
    return temp;
  }

  Future createOrUpdateFriendInfo(Friend _friend) async {
    var dbClient = await this.db;
    List<Map> friend = await dbClient
        .query(Friend.tableName, where: "id=?", whereArgs: [_friend.id]);
    Map tempFriend = _friend.toMap();

    if (friend.length > 0) {
      tempFriend.remove("id");
      await dbClient.update(Friend.tableName, tempFriend,
          where: "id=?", whereArgs: [_friend.id]);
    } else {
      await dbClient.insert(Friend.tableName, _friend.toMap());
    }
  }

  Future saveMessage(Message message) async {
    var dbClient = await this.db;
    int id = await dbClient.insert(Message.tableName, message.toMap());
  }

  Future<List<Message>> getFriendChatMessage(Friend _friend) async {
    var dbClient = await this.db;

    // Message().senderId
    // Message().reciver
    List<Map> message = await dbClient.rawQuery(
        "select * from ${Message.tableName} WHERE (senderId = '${Authentication.user.id}' AND reciver = '${_friend.id}') or (reciver = '${Authentication.user.id}' AND senderId = '${_friend.id}')");
    List<Message> temp = [];
    message.forEach((element) {
      temp.add(Message.fromMap(element));
    });
    return temp;
  }

  Future<bool> checkRoom(String id, bool isGroup) async {
    var dbClient = await this.db;
    String whereStr = "id=? and isGroup=?";
    List WhereArgs = [id];
    if (isGroup) {
      WhereArgs.add(1);
    } else {
      WhereArgs.add(0);
    }
    List<Map> rooms = await dbClient.query(Room.tableName,
        where: whereStr, whereArgs: WhereArgs);
    if (rooms.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future updateRoomLastMessage(String id, String message) async {
    var dbClient = await this.db;
    await dbClient.update(Room.tableName, {"lastMessage": message},
        where: "id=?", whereArgs: [id]);
  }

  Future createNewRoom(Room room) async {
    var dbClient = await this.db;
    await dbClient.insert(Room.tableName, room.toMap());
  }

  Future getRooms() async {
    var dbClient = await this.db;
    List<Map> rooms = await dbClient.query(Room.tableName);
    List<Room> temp = [];
    rooms.forEach((element) {
      temp.add(Room.fromMap(element));
    });
    return temp;
  }

  Future logout() async {
    var db = await this.db;
    await Friend().dropTable(db);
    await Group().dropTable(db);
    await User().dropTable(db);
    await Message().dropTable(db);
    await Room().dropTable(db);
    await Friend().createTable(db);
    await Group().createTable(db);
    await User().createTable(db);
    await Message().createTable(db);
    await Room().createTable(db);
  }
}
