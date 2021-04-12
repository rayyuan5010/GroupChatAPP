library text_message_widget;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'text_message_mobile.dart';
part 'text_message_tablet.dart';
part 'text_message_desktop.dart';

class TextMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _TextMessageMobile(),
        desktop: _TextMessageDesktop(),
        tablet: _TextMessageTablet(),
    );
  }
}