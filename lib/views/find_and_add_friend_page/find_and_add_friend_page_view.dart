library find_and_add_friend_page_view;

import 'package:faker/faker.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'find_and_add_friend_page_view_model.dart';

part 'find_and_add_friend_page_mobile.dart';
part 'find_and_add_friend_page_tablet.dart';
part 'find_and_add_friend_page_desktop.dart';

class FindAndAddFriendPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FindAndAddFriendPageViewModel viewModel = FindAndAddFriendPageViewModel();
    return ViewModelProvider<FindAndAddFriendPageViewModel>.withConsumer(
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _FindAndAddFriendPageMobile(viewModel),
          desktop: _FindAndAddFriendPageDesktop(viewModel),
          tablet: _FindAndAddFriendPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
