import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/model/user.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'apireturn.dart';
import 'config.dart';

class NetWorkAPI {
  DBHelper dbHelper = DBHelper();
  static List<Map> respondQ = [];
  static bool _isConnectionSuccessful = false;
  static ConnectivityResult _connectionStatus = ConnectivityResult.none;
  static Connectivity _connectivity = Connectivity();
  static StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static clearQ() {
    _isConnectionSuccessful = true;
    if (respondQ.length > 0)
      respondQ.forEach((e) {
        _sendHTTP(e['data'], e['url']);
      });
  }

  static pingTheGoogle() async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        if (_isConnectionSuccessful == false) {
          clearQ();
        }
        _isConnectionSuccessful = true;
      } else {
        _isConnectionSuccessful = false;
      }
    });
  }

  static Future<APIReturn> _sendHTTP(Map<String, dynamic> data, String url,
      {bool resend = true}) async {
    if (_isConnectionSuccessful) {
      try {
        Response response;
        var dio = Dio();

        if (Authentication.user != null) {
          data.addAll({"AuthID": Authentication.user.id});
        } else {
          data.addAll({"AuthID": null});
        }

        var formData = FormData.fromMap(data);
        response = await dio.post(Config.apiURL(url), data: formData);
        getLogger("NetWorkAPI").d(response.statusCode);
        if (response.statusCode == 200) {
          // print(response.data);
          return APIReturn.fromMap(response.data);
        } else {
          return APIReturn(status: false, message: 'server error');
        }
      } catch (e) {
        Logger().e(e);
        return APIReturn(status: false, message: 'server error');
      }
    } else {
      if (resend) respondQ.add({"url": url, "data": data});
    }
  }

  static Future<APIReturn> createUser(String email, String password) async {
    return _sendHTTP({'email': email, 'password': password}, "/user/insert");
  }

  static Future<APIReturn> userLogin(String email, String password) async {
    return _sendHTTP({'email': email, 'password': password}, "/user/get");
  }

  static Future<APIReturn> getGroupAndFriend() async {
    APIReturn apiReturn = null;
    DBHelper dbHelper = new DBHelper();
    if (_isConnectionSuccessful) {
      apiReturn =
          await _sendHTTP({'userId': Authentication.user.id}, "/mixData/get");
      if (apiReturn.status) {
        List friendList = apiReturn.data['friendList'];
        friendList.forEach((e) {
          dbHelper.createOrUpdateFriendInfo(Friend.fromMap(e));
        });
      }
    }

    return apiReturn;
  }

  static Future<APIReturn> updateToken(String token) async {
    return _sendHTTP({'token': token}, "/user/token/update");
  }

  static Future<APIReturn> sendMessage(String receiverId, Message message,
      {bool group = false}) async {
    String str = json.encode(message.toMap());
    APIReturn apiReturn = await _sendHTTP({
      "receiverId": receiverId,
      "message": str,
      "senderId": Authentication.user.id
    }, "/message/insert", resend: false);
    if (apiReturn.status) {
      DBHelper dbHelper = new DBHelper();
      dbHelper.saveMessage(message);
    }
    return apiReturn;
  }

  static Future getSelfInfo() async {
    APIReturn resp =
        await _sendHTTP({'userId': Authentication.user.id}, "/user/self/get");
    if (resp.status) {
      await DBHelper().updateSelfInfo(User.fromMap(resp.data));
    }
  }

  /*
  NOTE If no network, use local image,
       If same image id from server, use local image
       If not same id from server, download and save to folder


  */
  static Future<APIReturn> checkFirendHeadShot(String _id,
      {Function refresh}) async {
    DBHelper dbHelper = new DBHelper();
    Friend friend = await dbHelper.getFriendInfoByID(_id);
    final directory = await getExternalStorageDirectory();
    String imagePath = "${directory.path}/$_id/images/";
    String filePath = "${directory.path}/$_id/files/";
    bool headshotExists = false;
    if (friend != null) {
      String headshot = "$imagePath${friend.image}";
      headshotExists = await File("$headshot.jpg").exists();
    }

    if (!await Directory.fromUri(Uri.directory(imagePath)).exists()) {
      Directory.fromUri(Uri.directory(imagePath)).create(recursive: true);
    }
    if (!await Directory.fromUri(Uri.directory(filePath)).exists()) {
      Directory.fromUri(Uri.directory(filePath)).create(recursive: true);
    }

    if (_isConnectionSuccessful) {
      //have network
      APIReturn apiReturn = await _sendHTTP(
          {'userId': Authentication.user.id, 'friendId': _id}, "/friend/get");
      User tempUser = User.fromMap(apiReturn.data);

      if (friend != null && tempUser.image == friend.image && headshotExists) {
        return APIReturn(status: true, data: friend.image);
      } else {
        await downloadFile(Config.apiURL('/file/image/headshot?i=$_id'),
            tempUser.image, imagePath);

        return APIReturn(status: false, data: tempUser.image);
      }
    } else {
      return APIReturn(status: headshotExists, data: friend.image);
    }
  }

  static Future<String> downloadFile(
      String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url + '/' + fileName;
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName.jpg';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
    }
    print(filePath);
    return filePath;
  }
}
