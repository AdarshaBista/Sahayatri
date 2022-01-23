import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_tile.dart';

class CustomFormTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String hintText;
  final Widget? trailing;
  final VoidCallback onTap;

  const CustomFormTile({
    required this.icon,
    required this.onTap,
    required this.title,
    required this.hintText,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.t.headline5?.bold,
        ),
        const SizedBox(height: 8.0),
        CustomTile(
          icon: icon,
          title: hintText,
          onTap: onTap,
          trailing: trailing,
        ),
      ],
    );
  }
}
