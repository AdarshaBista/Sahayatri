import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/close_icon.dart';
import 'package:sahayatri/ui/widgets/appbars/custom_flexible_space.dart';

class CollapsibleAppbar extends StatelessWidget {
  final String title;
  final double height;
  final double offset;
  final Widget background;
  final double leftPadding;
  final VoidCallback onBack;

  const CollapsibleAppbar({
    @required this.title,
    this.onBack,
    this.offset,
    this.background,
    this.height = 110.0,
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
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CloseIcon(
          onTap: onBack,
          iconData: Icons.arrow_back,
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
