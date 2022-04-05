library custom_tab_widget;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'custom_tab_mobile.dart';
part 'custom_tab_tablet.dart';
part 'custom_tab_desktop.dart';

class CustomTabWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _CustomTabMobile(),
        desktop: _CustomTabDesktop(),
        tablet: _CustomTabTablet(),
    );
  }
}