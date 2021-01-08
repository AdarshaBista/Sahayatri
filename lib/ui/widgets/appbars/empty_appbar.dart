import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/exit_button.dart';

class EmptyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ExitButton(
          size: 20.0,
          color: context.c.onBackground,
          icon: AppIcons.back,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
