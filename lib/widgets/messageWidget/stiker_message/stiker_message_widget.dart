library stiker_message_widget;

import 'package:group_chat/other/message.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'stiker_message_mobile.dart';
part 'stiker_message_tablet.dart';
part 'stiker_message_desktop.dart';

class StikerMessageWidget extends StatelessWidget {
  StikerMessageWidget({@required this.message, @required this.self})
      : super(key: UniqueKey());
  final Message message;
  final bool self;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _StikerMessageMobile(message: message, self: self),
      desktop: _StikerMessageDesktop(),
      tablet: _StikerMessageTablet(),
    );
  }
}
