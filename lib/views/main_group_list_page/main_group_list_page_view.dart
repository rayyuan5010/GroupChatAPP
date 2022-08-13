library main_group_list_page_view;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_chat/core/locator.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/core/services/navigator_service.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/group.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/apireturn.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/config.dart';
import 'package:group_chat/views/find_and_add_friend_page/find_and_add_friend_page_view.dart';
import 'package:group_chat/views/headshot_preview_page/headshot_preview_page_view.dart';
import 'package:group_chat/views/message_page/message_page_view.dart';
import 'package:group_chat/widgets/firend_message_headshot/firend_message_headshot_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

import 'main_group_list_page_view_model.dart';

part 'main_group_list_page_mobile.dart';
part 'main_group_list_page_tablet.dart';
part 'main_group_list_page_desktop.dart';

class MainGroupListPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainGroupListPageViewModel viewModel = MainGroupListPageViewModel();
    return ViewModelProvider<MainGroupListPageViewModel>.withConsumer(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _MainGroupListPageMobile(viewModel),
          desktop: _MainGroupListPageDesktop(viewModel),
          tablet: _MainGroupListPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
