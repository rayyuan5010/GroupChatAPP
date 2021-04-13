library text_message_widget;

import 'package:group_chat/other/message.dart';
import 'package:group_chat/theme/normal.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'text_message_mobile.dart';
part 'text_message_tablet.dart';
part 'text_message_desktop.dart';

class TextMessageWidget extends StatelessWidget {
  TextMessageWidget({@required this.message}) : super(key: UniqueKey());
  final Message message;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _TextMessageMobile(
        message: message,
      ),
      desktop: _TextMessageDesktop(),
      tablet: _TextMessageTablet(),
    );
  }
}
