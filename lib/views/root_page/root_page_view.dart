library root_page_view;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:group_chat/core/logger.dart';
import 'package:group_chat/model/message.dart' as m;
import 'package:group_chat/other/NetWorkAPI.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/config.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:group_chat/other/rootController.dart';
import 'package:group_chat/views/check_login_page/check_login_page_view.dart';
import 'package:group_chat/views/login_page/login_page_view.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';
import 'package:group_chat/views/main_page_root/main_page_root_view.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'root_page_view_model.dart';

part 'root_page_mobile.dart';
part 'root_page_tablet.dart';
part 'root_page_desktop.dart';

FirebaseMessaging messaging;
AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class RootPageView extends StatefulWidget {
  @override
  State<RootPageView> createState() => RootPageViewState();
}

class RootPageViewState extends State<RootPageView> {
  @override
  void initState() {
    super.initState();

    NetWorkAPI.pingTheGoogle();
    getDefaultPath();

    FirebaseMessaging.instance.subscribeToTopic("test");
    // 當 app 處於開啟狀態時，監聽推撥訊息用
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("message recieved");
      Logger().i(message.from);
      DBHelper dbHelper = new DBHelper();
      Logger().d(message.data);
      m.Message tMessage = m.Message.fromMap(message.data);
      Config.checkNeedToCreateRoom(tMessage);
      if (Config.currentUser != null &&
          Config.currentUser.id == tMessage.senderId) {
        Config.addMessage(tMessage);
      } else {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        channel = AndroidNotificationChannel(
          tMessage.senderId, // id
          'High Importance Notifications', // title
          description:
              'This channel is used for important notifications.', // description
          importance: Importance.high,
        );
        // /// Create an Android Notification Channel.
        // ///
        // /// We use this channel in the `AndroidManifest.xml` file to override the
        // /// default FCM channel to enable heads up notifications.
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        if (notification != null && android != null) {
          await flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: 'launch_background',
                ),
              ));
        }
      }

      await dbHelper.saveMessage(tMessage);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // 這邊可以寫在 app 關閉狀態，點通知訊息時，打開 app 後要做的事情
    });
  }

  getDefaultPath() async {
    Directory path = await getExternalStorageDirectory();
    Config.defaultPath = path.path;
  }

  @override
  Widget build(BuildContext context) {
    RootPageViewModel viewModel = RootPageViewModel();

    return ViewModelProvider<RootPageViewModel>.withConsumer(
      onModelReady: (viewModel) {
        RootPageController.rootPageViewModel = viewModel;
        viewModel.checkLoginStaus();
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _RootPageMobile(viewModel),
          desktop: _RootPageDesktop(viewModel),
          tablet: _RootPageTablet(viewModel),
        );
      },
      viewModelBuilder: () {
        return viewModel;
      },
    );
  }
}
