library main_page_root_view;

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'main_page_root_view_model.dart';

part 'main_page_root_mobile.dart';
part 'main_page_root_tablet.dart';
part 'main_page_root_desktop.dart';

class MainPageRootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainPageRootViewModel viewModel = MainPageRootViewModel();
    return ViewModelProvider<MainPageRootViewModel>.withConsumer(
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _MainPageRootMobile(viewModel),
          desktop: _MainPageRootDesktop(viewModel),
          tablet: _MainPageRootTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
