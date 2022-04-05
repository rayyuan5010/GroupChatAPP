library message_list_widget;

import 'package:group_chat/widgets/message/message_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'message_list_mobile.dart';
part 'message_list_tablet.dart';
part 'message_list_desktop.dart';

class MessageListWidget extends StatelessWidget {
  MessageListWidget(
      {Key key, @required this.children, @required this.controller})
      : super(key: key);
  List<MessageWidget> children;
  ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _MessageListMobile(children: children, controller: controller),
      desktop: _MessageListMobile(),
      tablet: _MessageListMobile(),
    );
  }
}
