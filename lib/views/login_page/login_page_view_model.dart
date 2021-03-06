import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/model/user.dart';
import 'package:group_chat/other/apireturn.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/rootController.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';
import 'package:group_chat/views/root_page/root_page_view_model.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'dart:core';

import 'package:sqflite/sqflite.dart';

class LoginPageViewModel extends BaseViewModel {
  LoginPageViewModel();

  Future<String> authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      DBHelper dbHelper = new DBHelper();
      Database database = await dbHelper.db;
      // dbHelper.checkLogin();

      APIReturn resp = await NetWorkAPI.userLogin(data.name, data.password);
      if (resp.status) {
        DBHelper dbHelper = new DBHelper();
        Database database = await dbHelper.db;

        Authentication.status = LoginStatus.signIn;
        print(resp.data);
        Authentication.user = User(
            id: resp.data['id'],
            account: resp.data['email'],
            name: resp.data['name'],
            password: resp.data['password'],
            firendCode: resp.data['friend'],
            userSM: resp.data['userSM']);
        await database.insert(
          'tb_userInfo',
          Authentication.user.toMap(),
        );
        Authentication.status = LoginStatus.signIn;
        return null;
      } else {
        return resp.message;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> signup(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
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
            firendCode: resp.data['friend'],
            userSM: resp.data['userSM']);
        await database.insert(
          'tb_userInfo',
          Authentication.user.toMap(),
        );
        Authentication.status = LoginStatus.signIn;
        return null;
      } else {
        return resp.message;
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
    return '123';
    // });
  }

  Future<String> recoverPassword(String name) {
    print('Name: $name');
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
      return '?????????????????????';
    }
    return null;
  };
  FormFieldValidator<String> passwordValidator = (value) {
    if (value.isEmpty || value.length <= 5) {
      return '???????????????';
    }

    return null;
  };

  // Add ViewModel specific code here
}
