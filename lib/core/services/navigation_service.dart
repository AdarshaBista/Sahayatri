import 'package:flutter/material.dart';

abstract class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

  const NavigationService(this.navigatorKey);

  Future<void> pushNamed(String routeName, {Object arguments}) async {
    await navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void pop() {
    navigatorKey.currentState.pop();
  }

  bool canPop() {
    return navigatorKey.currentState.canPop();
  }
}

class RootNavService extends NavigationService {
  static final rootNavKey = GlobalKey<NavigatorState>();
  RootNavService() : super(rootNavKey);
}

class DestinationNavService extends NavigationService {
  static final destinationNavKey = GlobalKey<NavigatorState>();
  DestinationNavService() : super(destinationNavKey);
}
