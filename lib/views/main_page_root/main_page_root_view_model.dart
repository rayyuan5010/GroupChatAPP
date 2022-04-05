import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';
import 'package:group_chat/views/setting_page/setting_page_view.dart';
import 'package:group_chat/views/talk_list/talk_list_view.dart';

class MainPageRootViewModel extends BaseViewModel {
  MainPageRootViewModel();

  int currentIndex = 0;
  List<Widget> pages = [
    MainGroupListPageView(),
    TalkListView(),
    Container(
      child: Text('page3'),
    ),
    SettingPageView(),
  ];
  PageController controller = new PageController();
}
