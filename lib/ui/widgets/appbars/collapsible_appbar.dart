import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/close_icon.dart';
import 'package:sahayatri/ui/widgets/appbars/custom_flexible_space.dart';

class CollapsibleAppbar extends StatelessWidget {
  final String title;
  final double height;
  final double offset;
  final Widget leading;
  final Widget trailing;
  final Widget background;
  final double leftPadding;
  final VoidCallback onBack;

  const CollapsibleAppbar({
    @required this.title,
    this.onBack,
    this.offset,
    this.leading,
    this.trailing,
    this.background,
    this.height = 100.0,
    this.leftPadding = 20.0,
  })  : assert(title != null),
        assert(height != null),
        assert(leftPadding != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 6.0,
      expandedHeight: height,
      actions: trailing == null ? [] : [trailing],
      leading: leading ??
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CloseIcon(
              size: 20.0,
              onTap: onBack,
              iconData: Icons.keyboard_backspace,
              iconColor: context.c.onBackground,
              backgroundColor: context.c.background,
            ),
          ),
      flexibleSpace: CustomFlexibleSpace(
        title: title,
        offset: offset,
        background: background,
        leftPadding: leftPadding,
      ),
    );
  }
}
