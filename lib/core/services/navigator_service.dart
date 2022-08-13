import '../../core/base/base_service.dart';
import 'package:flutter/material.dart';

class NavigatorService extends BaseService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T> navigateToPage<T>(
    Widget widget,
    RouteSettings routeSettings,
  ) async {
    log.i('navigateToPage: pageRoute: ${routeSettings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPage: Navigator State is null');
      return null;
    }
    PageRoute<T> pageRoute = PageRouteBuilder(
      settings: RouteSettings(name: "MainGroupListPageMobile|Add friend"),
      pageBuilder:
          (BuildContext context, Animation<double> x, Animation<double> y) =>
              widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInQuad;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
    return navigatorKey.currentState.push(pageRoute);
  }

  Future<T> navigateToPageWithReplacement<T>(
      MaterialPageRoute<T> pageRoute) async {
    log.i('navigateToPageWithReplacement: '
        'pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPageWithReplacement: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.pushReplacement(pageRoute);
  }

  void pop<T>([T result]) {
    log.i('goBack:');
    if (navigatorKey.currentState == null) {
      log.e('goBack: Navigator State is null');
      return;
    }
    navigatorKey.currentState.pop(result);
  }

  transitionsBuilder(context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
}
