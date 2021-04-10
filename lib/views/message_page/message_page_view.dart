library message_page_view;

import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'message_page_view_model.dart';

part 'message_page_mobile.dart';
part 'message_page_tablet.dart';
part 'message_page_desktop.dart';

class MessagePageView extends StatelessWidget {
  MessagePageView({@required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    MessagePageViewModel viewModel = MessagePageViewModel(title: title);
    return ViewModelProvider<MessagePageViewModel>.withConsumer(
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _MessagePageMobile(viewModel),
          desktop: _MessagePageDesktop(viewModel),
          tablet: _MessagePageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}