import 'package:flutter/material.dart';

abstract class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

  const NavigationService(this.navigatorKey);

  Future<void> pushNamed(String routeName, {Object arguments}) async {
    await navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<void> pushReplacementNamed(String routeName, {Object arguments}) async {
    await navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }

  bool canPop() {
    return navigatorKey.currentState.canPop();
  }

  void pop() {
    navigatorKey.currentState.pop();
  }
}

// Navigation service for root pages of app
class RootNavService extends NavigationService {
  static final rootNavKey = GlobalKey<NavigatorState>();
  RootNavService() : super(rootNavKey);
}

/// Navigation service for navigating between pages
/// once a destiantion has been selected
class DestinationNavService extends NavigationService {
  static final destinationNavKey = GlobalKey<NavigatorState>();
  DestinationNavService() : super(destinationNavKey);
}
