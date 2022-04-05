library talk_list_view;

import 'package:faker/faker.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/views/message_page/message_page_view.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'talk_list_view_model.dart';

part 'talk_list_mobile.dart';
part 'talk_list_tablet.dart';
part 'talk_list_desktop.dart';

class TalkListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TalkListViewModel viewModel = TalkListViewModel();
    return ViewModelProvider<TalkListViewModel>.withConsumer(
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _TalkListMobile(viewModel),
          desktop: _TalkListDesktop(viewModel),
          tablet: _TalkListTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
