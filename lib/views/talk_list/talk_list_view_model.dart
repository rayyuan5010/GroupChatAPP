import 'dart:math';

import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/room.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';

class TalkListViewModel extends BaseViewModel {
  TalkListViewModel();
  TextEditingController controller = new TextEditingController();
  // Add ViewModel specific code here

  //debug

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  Future<List<Room>> getRoom() async {
    DBHelper dbHelper = new DBHelper();
    return <Room>[];
  }

  getRooms() async {
    DBHelper dbHelper = new DBHelper();
    rooms = await dbHelper.getRooms();
    // Logger().d(rooms);
    List<Friend> friends = await dbHelper.getFriends();
    friends.forEach((element) {
      friendWithID[element.id] = element;
    });
    notifyListeners();
  }

  addRoom() async {
    rooms = [];
    friendWithID = {};

    getRooms();
    notifyListeners();
  }

  Map<String, Friend> friendWithID = {};
  List<Room> rooms = [];
}
