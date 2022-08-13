library headshot_preview_page_view;

import 'package:group_chat/core/locator.dart';
import 'package:group_chat/core/services/navigator_service.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/config.dart';
import 'package:logger/logger.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'headshot_preview_page_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

part 'headshot_preview_page_mobile.dart';
part 'headshot_preview_page_tablet.dart';
part 'headshot_preview_page_desktop.dart';

class HeadshotPreviewPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HeadshotPreviewPageViewModel viewModel = HeadshotPreviewPageViewModel();
    return ViewModelProvider<HeadshotPreviewPageViewModel>.withConsumer(
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _HeadshotPreviewPageMobile(viewModel),
          desktop: _HeadshotPreviewPageDesktop(viewModel),
          tablet: _HeadshotPreviewPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
