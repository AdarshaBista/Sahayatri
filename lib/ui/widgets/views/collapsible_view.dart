import 'package:flutter/material.dart';

class CollapsibleView extends StatelessWidget {
  final Widget child;
  final Widget collapsible;

  const CollapsibleView({
    super.key,
    required this.child,
    required this.collapsible,
  });

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
