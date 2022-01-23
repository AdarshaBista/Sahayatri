import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/widgets/appbars/custom_flexible_space.dart';

class CollapsibleAppbar extends StatelessWidget {
  final String title;
  final double height;
  final double leftPadding;
  final Widget? background;
  final double? offset;
  final Widget? leading;
  final VoidCallback? onBack;

  const CollapsibleAppbar({
    required this.title,
    this.onBack,
    this.offset,
    this.leading,
    this.background,
    this.height = 100.0,
    this.leftPadding = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 6.0,
      expandedHeight: height,
      leading: leading ??
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircularButton(
              size: 20.0,
              icon: AppIcons.back,
              color: context.c.onBackground,
              backgroundColor: context.c.background,
              onTap: onBack ?? Navigator.of(context).pop,
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
