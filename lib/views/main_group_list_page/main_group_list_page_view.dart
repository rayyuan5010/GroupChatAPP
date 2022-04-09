library main_group_list_page_view;

import 'package:faker/faker.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/group.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/apireturn.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/views/message_page/message_page_view.dart';
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
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
        // NetWorkAPI.getGroup();
      },
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
