library message_type_tabl_widget;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:group_chat/core/locator.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/core/models/gif_image.dart';
import 'package:group_chat/core/services/navigator_service.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/apireturn.dart';
import 'package:group_chat/other/config.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

part 'message_type_tabl_mobile.dart';
part 'message_type_tabl_tablet.dart';
part 'message_type_tabl_desktop.dart';

class MessageTypeTablWidget extends StatelessWidget {
  MessageTypeTablWidget({@required this.onSelected});
  final Function(String) onSelected;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _MessageTypeTablMobile(onSelected: onSelected),
      desktop: _MessageTypeTablDesktop(),
      tablet: _MessageTypeTablTablet(),
    );
  }
}
