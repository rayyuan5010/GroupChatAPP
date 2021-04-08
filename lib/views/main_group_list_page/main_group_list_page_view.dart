library main_group_list_page_view;

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:faker/faker.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
