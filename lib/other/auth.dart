import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:group_chat/model/user.dart';
import 'package:group_chat/views/root_page/root_page_view_model.dart';

class Authentication {
  static User user;
  static LoginStatus status = LoginStatus.checkStatus;
}
