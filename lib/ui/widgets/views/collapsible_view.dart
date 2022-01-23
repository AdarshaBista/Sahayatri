import 'package:flutter/material.dart';

class CollapsibleView extends StatelessWidget {
  final Widget child;
  final Widget collapsible;

  const CollapsibleView({
    required this.child,
    required this.collapsible,
  })  : assert(child != null),
        assert(collapsible != null);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (_, __) {
        return [collapsible];
      },
      body: child,
    );
  }
}
