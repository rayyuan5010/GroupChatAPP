library root_page_view;

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/config.dart';
import 'package:group_chat/other/rootController.dart';
import 'package:group_chat/views/check_login_page/check_login_page_view.dart';
import 'package:group_chat/views/login_page/login_page_view.dart';
import 'package:group_chat/views/main_group_list_page/main_group_list_page_view.dart';
import 'package:group_chat/views/main_page_root/main_page_root_view.dart';
import 'package:logger/logger.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
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
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    // 當 app 處於開啟狀態時，監聽推撥訊息用
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("message recieved");
      print(message.data);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
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
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // 這邊可以寫在 app 關閉狀態，點通知訊息時，打開 app 後要做的事情
    });
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
