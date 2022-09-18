import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class MapDialog extends StatelessWidget {
  final Widget map;

  const MapDialog({
    super.key,
    required this.map,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SlideAnimator(
      begin: const Offset(0.6, 0.0),
      child: AlertDialog(
        elevation: 12.0,
        clipBehavior: Clip.antiAlias,
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.light,
        title: SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.7,
          child: map,
        ),
      ),
    );
  }
}
