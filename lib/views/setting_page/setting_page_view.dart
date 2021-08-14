library setting_page_view;

import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/rootController.dart';
import 'package:group_chat/views/root_page/root_page_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'setting_page_view_model.dart';

part 'setting_page_mobile.dart';
part 'setting_page_tablet.dart';
part 'setting_page_desktop.dart';

class SettingPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingPageViewModel viewModel = SettingPageViewModel();
    return ViewModelProvider<SettingPageViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _SettingPageMobile(viewModel),
          desktop: _SettingPageDesktop(viewModel),
          tablet: _SettingPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
