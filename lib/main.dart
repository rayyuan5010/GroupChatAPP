// import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:group_chat/model/message.dart' as m;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:group_chat/views/root_page/root_page_view.dart';
import 'package:imei_plugin/imei_plugin.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  DBHelper dbHelper = new DBHelper();

  // m.Message message = m.Message.fromMap({});
  print('Handling a background message ${message.data}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  await LocatorInjector.setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  String idunique = await ImeiPlugin.getId();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = ;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        navigatorKey: locator<NavigatorService>().navigatorKey,
        home: RootPageView(),
      ),
    );
  }
}

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: 'AIzaSyBaq7ekf5sM91pKJsjJ63CuZJJJv6oSY0k',
        appId: '1:528470124920:android:4851f706ff84c39337008d',
        messagingSenderId: '',
        projectId: 'groupchat-73545',
      );
    } else {
      // Android
      return const FirebaseOptions(
        apiKey: 'AIzaSyBaq7ekf5sM91pKJsjJ63CuZJJJv6oSY0k',
        appId: '1:528470124920:android:4851f706ff84c39337008d',
        messagingSenderId: '',
        projectId: 'groupchat-73545',
      );
    }
  }
}
