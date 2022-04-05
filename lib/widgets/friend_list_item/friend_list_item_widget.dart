library friend_list_item_widget;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'friend_list_item_mobile.dart';
part 'friend_list_item_tablet.dart';
part 'friend_list_item_desktop.dart';

class FriendListItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _FriendListItemMobile(),
        desktop: _FriendListItemDesktop(),
        tablet: _FriendListItemTablet(),
    );
  }
}