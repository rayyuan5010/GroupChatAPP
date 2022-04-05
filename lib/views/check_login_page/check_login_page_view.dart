library check_login_page_view;

import 'package:flutter/cupertino.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'check_login_page_view_model.dart';

part 'check_login_page_mobile.dart';
part 'check_login_page_tablet.dart';
part 'check_login_page_desktop.dart';

class CheckLoginPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CheckLoginPageViewModel viewModel = CheckLoginPageViewModel();
    return ViewModelProvider<CheckLoginPageViewModel>.withConsumer(
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized

      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _CheckLoginPageMobile(viewModel),
          desktop: _CheckLoginPageDesktop(viewModel),
          tablet: _CheckLoginPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
