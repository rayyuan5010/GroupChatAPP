library root_page_view;

import 'package:group_chat/views/check_login_page/check_login_page_view.dart';
import 'package:group_chat/views/login_page/login_page_view.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'root_page_view_model.dart';

part 'root_page_mobile.dart';
part 'root_page_tablet.dart';
part 'root_page_desktop.dart';

class RootPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RootPageViewModel viewModel = RootPageViewModel();
    return ViewModelProvider<RootPageViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.checkLoginStaus();
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _RootPageMobile(viewModel),
          desktop: _RootPageDesktop(viewModel),
          tablet: _RootPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
