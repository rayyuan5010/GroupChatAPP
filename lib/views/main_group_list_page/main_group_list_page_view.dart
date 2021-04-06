library main_group_list_page_view;

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
