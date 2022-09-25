import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/model/user.dart';
import 'package:group_chat/other/apireturn.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/rootController.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';
import 'package:group_chat/views/root_page/root_page_view.dart';
import 'package:group_chat/views/root_page/root_page_view_model.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'dart:core';

import 'package:sqflite/sqflite.dart';

class LoginPageViewModel extends BaseViewModel {
  LoginPageViewModel();

  Future<String> authUser(LoginData data) async {
    try {
      DBHelper dbHelper = new DBHelper();
      Database database = await dbHelper.db;
      // dbHelper.checkLogin();

      APIReturn resp = await NetWorkAPI.userLogin(data.name, data.password);
      if (resp.status) {
        DBHelper dbHelper = new DBHelper();
        Database database = await dbHelper.db;

        Authentication.status = LoginStatus.signIn;
        getLogger(className: "authUser").d(resp.data);
        Authentication.user = User(
            id: resp.data['id'],
            account: resp.data['email'],
            name: resp.data['name'],
            password: resp.data['password'],
            friendCode: resp.data['friendCode'],
            userSM: resp.data['userSM'],
            image: resp.data['image']);
        await database.insert(
          'tb_userInfo',
          Authentication.user.toMap(),
        );
        notifyListeners();
        Authentication.status = LoginStatus.signIn;
        return null;
      } else {
        return resp.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signup(LoginData data) async {
    try {
      APIReturn resp = await NetWorkAPI.createUser(data.name, data.password);

      if (resp.status) {
        DBHelper dbHelper = new DBHelper();
        Database database = await dbHelper.db;

        Authentication.user = User(
            id: resp.data['id'],
            account: resp.data['email'],
            name: resp.data['name'],
            password: resp.data['password'],
            friendCode: resp.data['friendCode'],
            userSM: resp.data['userSM']);
        await database.insert(
          'tb_userInfo',
          Authentication.user.toMap(),
        );
        Authentication.status = LoginStatus.signIn;
        messaging.getToken().then((value) async {
          getLogger(className: "LoginPageViewModel").d(value);
          await NetWorkAPI.updateToken(value);
        });
        return null;
      } else {
        return resp.message;
      }
    } catch (e) {
      return e.toString();
    }

    // });
  }

  Future<String> recoverPassword(String name) {
    // return Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(name)) {
    //     return 'Username not exists';
    //   }
    return null;
    // });
  }

  FormFieldValidator<String> emailValidator = (value) {
    if (value.isEmpty ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return '錯誤的信箱格式';
    }
    return null;
  };
  FormFieldValidator<String> passwordValidator = (value) {
    if (value.isEmpty || value.length <= 5) {
      return '密碼太短囉';
    }

    return null;
  };

  // Add ViewModel specific code here
}
