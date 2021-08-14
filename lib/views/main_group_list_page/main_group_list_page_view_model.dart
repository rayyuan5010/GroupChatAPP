import 'package:dio/dio.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/other/auth.dart';

class MainGroupListPageViewModel extends BaseViewModel {
  MainGroupListPageViewModel();
  TextEditingController controller = new TextEditingController();
  ExpandableSliverListController<int> listcontroller =
      ExpandableSliverListController();
  bool firendListIsOpen = true;
  bool groupListIsOpen = true;
  List<int> items = [1, 2, 3, 4, 5];

  Future getGroup() async {
    Response response;
    var dio = Dio();
    var formData = FormData.fromMap({'userId': Authentication.user.id});
    response = await dio.post('http://minecraftseverr.ddns.net/api/group/get',
        data: formData);
    if (response.statusCode == 200 && response.data is Map) {
      return response.data;
    } else {
      return {"status": false, "message": "internet error"};
    }
  }
}
