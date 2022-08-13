library text_message_widget;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/theme/appThemes.dart';
import 'package:group_chat/widgets/firend_message_headshot/firend_message_headshot_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import '../../other/message.dart';

part 'text_message_mobile.dart';
part 'text_message_tablet.dart';
part 'text_message_desktop.dart';

class TextMessageWidget extends StatelessWidget {
  TextMessageWidget(
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
      mobile: _TextMessageMobile(
          message: message, self: self, showTime: showTime, showHead: showHead),
      desktop: _TextMessageDesktop(),
      tablet: _TextMessageTablet(),
    );
  }
}
