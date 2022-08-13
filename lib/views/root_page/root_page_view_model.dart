import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/model/user.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/config.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:logger/logger.dart';

class RootPageViewModel extends BaseViewModel {
  RootPageViewModel();
  // LoginStatus status = LoginStatus.checkStatus;
  checkLoginStaus() async {
    DBHelper dbHelper = new DBHelper();
    User user = await dbHelper.checkLogin();

    // User user = FirebaseAuth.instance.currentUser;
    // print(user);
    if (user == null) {
      Authentication.status = LoginStatus.noSingIn;
    } else {
      Authentication.user = user;
      Authentication.status = LoginStatus.signIn;
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      // update user info
      NetWorkAPI.getSelfInfo();
      user = await dbHelper.checkLogin();
      messaging.getToken().then((value) async {
        Logger().d("FCM TOKEN:$value");
        await NetWorkAPI.updateToken(value);
      });
    }
    notifyListeners();
  }
  // Add ViewModel specific code here
}

enum LoginStatus { noSingIn, signIn, checkStatus }
