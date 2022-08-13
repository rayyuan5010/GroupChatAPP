import 'dart:io';

import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/model/room.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:path_provider/path_provider.dart';

class Config {
  static String serverIP = "rayyuandst1.ddns.net";
  static bool debug = true;
  static String apiURL(String url) {
    return 'http://${serverIP}/api$url';
  }

  static String defaultPath;
  static Friend currentUser;
  static Function(Message) addMessage;
  static Function() addRoom;
  static File getHeadShot(String id, String image) {
    String imagePath = "$defaultPath/$id/images/";
    String headshot = "$imagePath$image.jpg";

    return File(headshot);
  }

  static checkNeedToCreateRoom(Message message) async {
    if (message.groupId == "") {
      DBHelper dbHelper = new DBHelper();
      if (await dbHelper.checkRoom(message.senderId, false)) {
        await dbHelper.updateRoomLastMessage(
            message.senderId, message.messageContent);
      } else {
        Friend friend = await dbHelper.getFriendInfoByID(message.senderId);
        await dbHelper.createNewRoom(Room(
            id: message.senderId,
            name: friend.name,
            image: friend.image,
            lastMessage: message.messageContent,
            isGroup: false));
      }
    }
    if (Config.addRoom != null) {
      Config.addRoom();
    }
  }

  static Map<String, Friend> friendCache = {};
}
