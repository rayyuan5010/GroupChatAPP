library message_page_view;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_chat/other/message.dart';
import 'package:group_chat/widgets/message/message_widget.dart';

import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../other/message.dart';
import '../../widgets/google_map/google_map_widget.dart';
import 'message_page_view_model.dart';

part 'message_page_mobile.dart';
part 'message_page_tablet.dart';
part 'message_page_desktop.dart';

class MessagePageView extends StatelessWidget {
  MessagePageView({@required this.title}) : super(key: UniqueKey());
  final String title;
  @override
  Widget build(BuildContext context) {
    MessagePageViewModel viewModel = MessagePageViewModel(title: title);
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
