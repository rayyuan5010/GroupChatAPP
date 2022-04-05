library message_page_map_widget;

import 'dart:html';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'message_page_map_mobile.dart';
part 'message_page_map_tablet.dart';
part 'message_page_map_desktop.dart';

class MessagePageMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _MessagePageMapMobile(),
      desktop: _MessagePageMapDesktop(),
      tablet: _MessagePageMapTablet(),
    );
  }
}
