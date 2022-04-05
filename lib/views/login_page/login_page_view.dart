library login_page_view;

import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:group_chat/other/rootController.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'login_page_view_model.dart';

part 'login_page_mobile.dart';
part 'login_page_tablet.dart';
part 'login_page_desktop.dart';

class LoginPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginPageViewModel viewModel = LoginPageViewModel();

    return ViewModelProvider<LoginPageViewModel>.withConsumer(
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _LoginPageMobile(viewModel),
          desktop: _LoginPageDesktop(viewModel),
          tablet: _LoginPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
