library stiker_message_widget;

import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:group_chat/core/models/gif_image.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/config.dart';
import 'package:group_chat/theme/appThemes.dart';
import 'package:group_chat/widgets/firend_message_headshot/firend_message_headshot_widget.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'stiker_message_mobile.dart';
part 'stiker_message_tablet.dart';
part 'stiker_message_desktop.dart';

class StikerMessageWidget extends StatelessWidget {
  StikerMessageWidget(
      {@required this.message,
      @required this.self,
      @required this.showHead,
      @required this.showTime})
      : super(key: UniqueKey());
  final bool showTime;
  final bool showHead;
  final Message message;
  final bool self;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _StikerMessageMobile(
          message: message, self: self, showHead: showHead, showTime: showTime),
      desktop: _StikerMessageDesktop(),
      tablet: _StikerMessageTablet(),
    );
  }
}
