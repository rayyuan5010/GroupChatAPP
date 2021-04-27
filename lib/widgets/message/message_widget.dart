library message_widget;

import 'package:group_chat/other/message.dart';
import 'package:group_chat/widgets/messageWidget/image_message/image_message_widget.dart';
import 'package:group_chat/widgets/messageWidget/stiker_message/stiker_message_widget.dart';

import 'package:group_chat/widgets/messageWidget/text_message/text_message_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'message_mobile.dart';
part 'message_tablet.dart';
part 'message_desktop.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({@required this.message}) : super(key: UniqueKey());
  final Message message;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _MessageMobile(
        message: message,
      ),
      desktop: _MessageDesktop(),
      tablet: _MessageTablet(),
    );
  }
}
