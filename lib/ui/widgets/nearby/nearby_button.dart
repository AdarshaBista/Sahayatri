import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/buttons/column_button.dart';

class NearbyButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const NearbyButton({
    @required this.icon,
    @required this.label,
    @required this.color,
    @required this.onTap,
  })  : assert(icon != null),
        assert(label != null),
        assert(color != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: ColumnButton(
          label: label,
          icon: icon,
          onTap: onTap,
        ),
      ),
    );
  }
}
