import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:group_chat/views/root_page/root_page_view.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocatorInjector.setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
