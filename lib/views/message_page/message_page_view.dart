library message_page_view;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/group.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/widgets/message/message_widget.dart';
import 'package:group_chat/widgets/message_list/message_list_widget.dart';

import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../model/message.dart';
import '../../widgets/google_map/google_map_widget.dart';
import 'message_page_view_model.dart';

part 'message_page_mobile.dart';
part 'message_page_tablet.dart';
part 'message_page_desktop.dart';

class MessagePageView extends StatelessWidget {
  MessagePageView(
      {@required this.friend, @required this.group, this.isGroupChat = false})
      : super(key: UniqueKey());
  final Friend friend;
  final Group group;
  final bool isGroupChat;
  @override
  Widget build(BuildContext context) {
    MessagePageViewModel viewModel =
        MessagePageViewModel(title: isGroupChat ? group.name : friend.name);
    return ViewModelProvider<MessagePageViewModel>.withConsumer(
      onModelReady: (viewModel) {
        viewModel.getPosition(context);
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _MessagePageMobile(viewModel),
          desktop: _MessagePageDesktop(viewModel),
          tablet: _MessagePageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
