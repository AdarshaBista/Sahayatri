import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String hintText;
  final Widget trailing;
  final VoidCallback onTap;

  const CustomTile({
    @required this.icon,
    @required this.onTap,
    @required this.title,
    @required this.hintText,
    this.trailing,
  })  : assert(icon != null),
        assert(onTap != null),
        assert(title != null),
        assert(hintText != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        CustomCard(
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            onTap: onTap,
            trailing: trailing,
            title: Row(
              children: [
                Icon(
                  icon,
                  size: 20.0,
                  color: Colors.black45,
                ),
                const SizedBox(width: 16.0),
                Text(
                  hintText,
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
