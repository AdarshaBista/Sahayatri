import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/common/header.dart';

class SheetHeader extends StatelessWidget {
  final String title;
  final bool showDivider;
  final VoidCallback onClose;

  const SheetHeader({
    @required this.title,
    this.onClose,
    this.showDivider = true,
  })  : assert(title != null),
        assert(showDivider != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onClose != null) ...[
          GestureDetector(
            onTap: onClose,
            child: const Icon(Icons.keyboard_backspace),
          ),
          const SizedBox(height: 10.0),
        ],
        Header(
          title: title,
          padding: 0.0,
          fontSize: 20.0,
        ),
        if (showDivider) const Divider(height: 20.0),
      ],
    );
  }
}
