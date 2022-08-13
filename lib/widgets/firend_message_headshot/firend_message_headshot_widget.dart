library firend_message_headshot_widget;

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/apireturn.dart';
import 'package:group_chat/other/config.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'firend_message_headshot_mobile.dart';
part 'firend_message_headshot_tablet.dart';
part 'firend_message_headshot_desktop.dart';

class FirendMessageHeadshotWidget extends StatelessWidget {
  FirendMessageHeadshotWidget({@required this.id, this.size = 25.0})
      : super(key: UniqueKey());
  final String id;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _FirendMessageHeadshotMobile(id: id, size: size),
      desktop: _FirendMessageHeadshotDesktop(),
      tablet: _FirendMessageHeadshotTablet(),
    );
  }
}
