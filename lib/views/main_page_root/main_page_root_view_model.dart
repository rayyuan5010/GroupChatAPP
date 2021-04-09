import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';

class MainPageRootViewModel extends BaseViewModel {
  MainPageRootViewModel();

  int currentIndex = 0;
  List<Widget> pages = [
    MainGroupListPageView(),
    Container(
      child: Text('page2'),
    ),
    Container(
      child: Text('page3'),
    ),
  ];
  PageController controller = new PageController();
}
