import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/model/friend.dart';
import 'package:group_chat/model/group.dart';
import 'package:group_chat/model/message.dart';
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessagePageViewModel extends BaseViewModel {
  MessagePageViewModel(
      {@required this.title,
      @required this.friend,
      @required this.group,
      @required this.isGroupChat});
  final Friend friend;
  final Group group;
  final bool isGroupChat;
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
  void getPosition(
      BuildContext context, Completer<GoogleMapController> _controller) async {
    final position = await Geolocator.getCurrentPosition();
    final GoogleMapController controller = await _controller.future;

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
    messageList.addAll(messages);
    await Future.delayed(const Duration(milliseconds: 200));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn);
    });
    notifyListeners();
  }

  sendMessage(
      {MessageType type = MessageType.TEXT, String otherMessage = ""}) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    Logger().d(time);
    String message = sendMessageController.text;
    if (type == MessageType.TEXT && message.isEmpty) {
      return;
    }
    if (type != MessageType.TEXT) {
      message = otherMessage;
    }
    Message Tmessage = Message.fromMap({
      "senderId": Authentication.user.id,
      "senderName": Authentication.user.name,
      "reciver": friend.id,
      "reciveType": "0",
      "messageId": "${Authentication.user.id}-${time}",
      "messageType": type.index.toString(),
      "messageTime": "$time",
      "messageContent": message,
      "messageTabId": "0"
    });
    messageList.add(Tmessage);
    NetWorkAPI.sendMessage(
      isGroupChat ? group.id : friend.id,
      Tmessage,
    );
    sendMessageController.clear();
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });
  }
}
