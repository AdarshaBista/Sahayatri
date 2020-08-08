import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerIcon extends StatefulWidget {
  const DrawerIcon();

  @override
  _DrawerIconState createState() => _DrawerIconState();
}

class _DrawerIconState extends State<DrawerIcon> with SingleTickerProviderStateMixin {
  AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final drawerStateNotifier = ZoomDrawer.of(context).stateNotifier;
    drawerStateNotifier.addListener(() {
      if (drawerStateNotifier.value == DrawerState.opening) {
        animController.forward();
      }
      if (drawerStateNotifier.value == DrawerState.closing) {
        animController.reverse();
      }
    });
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: animController,
      ),
      onPressed: () {
        final drawerController = ZoomDrawer.of(context);

        if (drawerController.isOpen()) {
          animController.reverse();
        } else {
          animController.forward();
        }
        drawerController.toggle();
      },
    );
  }
}
