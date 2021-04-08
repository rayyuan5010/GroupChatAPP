import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_view_model.dart';

class MainGroupListPageViewModel extends BaseViewModel {
  MainGroupListPageViewModel();
  TextEditingController controller = new TextEditingController();
  ExpandableSliverListController<int> listcontroller =
      ExpandableSliverListController();

  List<int> items = [1, 2, 3, 4, 5];
}
