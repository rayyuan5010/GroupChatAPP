import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessagePageViewModel extends BaseViewModel {
  MessagePageViewModel({@required this.title});
  final String title;
  PageController controller = new PageController();
  Completer<GoogleMapController> mapController = Completer();
  ScrollController scrollController = ScrollController();

  double messageTotalHeight = 0.0;
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  TextEditingController textEditingController = new TextEditingController();
  double showForTop(height) => height / 100 * 45;
  bool first = true;
  double showForBottom(height) => height / 100 * 41;
  bool isShow = true;
  bool isContainerShow = false;
  Set<Marker> markers = {};
  Position position;
  TextEditingController sendMessageController = new TextEditingController();
  List<Message> messageList = [];
  String preMessageSender = null;
  String nextSender = null;
  void getPosition(context) async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    )));

    markers.add(Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(position.latitude, position.longitude),
        onTap: () {
          final snackBar = SnackBar(content: Text('你的位置'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }));
    notifyListeners();
    print("ready");
  }

  bool keyboardIsVisible(BuildContext context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  addMessage(Message message) async {
    messageList.add(message);
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });
  }

  getOldMessage(Friend friend) async {
    DBHelper dbHelper = new DBHelper();
    List<Message> messages = await dbHelper.getFriendChatMessage(friend);
    // print(messages.runtimeType);
    messageList.addAll(messages);
    // notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn);
    });
    notifyListeners();
  }
}
