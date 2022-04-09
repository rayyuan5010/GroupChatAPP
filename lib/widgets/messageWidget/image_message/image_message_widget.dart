library image_message_widget;

import 'package:group_chat/model/message.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'image_message_mobile.dart';
part 'image_message_tablet.dart';
part 'image_message_desktop.dart';

class ImageMessageWidget extends StatelessWidget {
  ImageMessageWidget({@required this.message, @required this.self})
      : super(key: UniqueKey());
  final Message message;
  final bool self;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _ImageMessageMobile(message: message, self: self),
      desktop: _ImageMessageDesktop(),
      tablet: _ImageMessageTablet(),
    );
  }
}
