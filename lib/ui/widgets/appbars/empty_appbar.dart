import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/close_icon.dart';

class EmptyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CloseIcon(
          size: 20.0,
          iconColor: context.c.onBackground,
          backgroundColor: Colors.transparent,
          iconData: Icons.keyboard_backspace,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
