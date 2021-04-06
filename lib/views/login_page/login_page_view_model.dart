import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'dart:core';

class LoginPageViewModel extends BaseViewModel {
  LoginPageViewModel();
  Future<String> authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.name, password: data.password);
      Authentication.user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: data.name, password: data.password);
        Authentication.user = userCredential.user;
        if (e.code == 'wrong-password') {
          return 'Wrong password provided for that user.';
        }
      }
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
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

  Function onComplete = (context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MainGroupListPageView(),
    ));
  };

  // Add ViewModel specific code here
}
