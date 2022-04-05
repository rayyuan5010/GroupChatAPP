import 'dart:math';

import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_view_model.dart';

class TalkListViewModel extends BaseViewModel {
  TalkListViewModel();
  TextEditingController controller = new TextEditingController();
  // Add ViewModel specific code here

  //debug

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
